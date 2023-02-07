<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use App\Http\Helpers\Cart;
use App\Enums\OrderStatus;
use App\Enums\PaymentStatus;
use App\Models\Order;
use App\Models\Payment;
use App\Models\CartItem;

class CheckoutController extends Controller
{
    public function checkout(Request $request){
        $user = $request->user();
        \Stripe\Stripe::setApiKey(getenv('STRIPE_SECRET_KEY'));

        list($products, $cartItems) = Cart::getProductsAndCartItems();

        $lineItems = [];
        $totalPrice = 0.0;
        foreach($products as $product){
            $quantity = $cartItems[$product->id]['quantity'];
            $lineItems[] = [
                'price_data' => [
                    'currency' => 'usd',
                    'product_data' => [
                        'name' => $product->title,
                        'images' => [$product->image],
                    ],
                    'unit_amount' => $product->price * 100,
                ],
                'quantity' => $quantity,
            ];
            $totalPrice += $product->price * $quantity;
        }

        $checkout_session = \Stripe\Checkout\Session::create([
            'line_items' => $lineItems,
            'mode' => 'payment',
            'success_url' => route('checkout.success', [], true).'?session_id='.'{CHECKOUT_SESSION_ID}',
            'cancel_url' => route('checkout.failure', [], true),
        ]);

        $orderData = [
            'total_price' => $totalPrice,
            'status' => OrderStatus::Unpaid,
            'created_by' => $user->id,
            'updated_by' => $user->id,
        ];
        $order = Order::create($orderData);

        $paymentData = [
            'order_id' => $order->id,
            'amount' => $totalPrice,
            'status' => PaymentStatus::Pending,
            'type' => 'cc',
            'created_by' => $user->id,
            'updated_by' => $user->id,
            'session_id' => $checkout_session->id,
        ];
        Payment::create($paymentData);
        return redirect($checkout_session->url);
    }

    public function success(Request $request)
    {
        $session_id = $request->get('session_id');
        $user = $request->user();
        \Stripe\Stripe::setApiKey(getenv('STRIPE_SECRET_KEY'));
        try{
            $session = \Stripe\Checkout\Session::retrieve($session_id);
            if (!$session){
                return view('checkout.failure', ['message' => 'Invalid Session id']);
            }
            $payment = Payment::query()->where(['session_id' => $session->id, 'status' => PaymentStatus::Pending])->first();
            if (!$payment || $payment->status != PaymentStatus::Pending){
                return view('checkout.failure', ['message' => 'Payment does nor exitst']);
            }

            $payment->status = PaymentStatus::Paid;
            $payment->update();

            $order = $payment->order;
            $order->status = OrderStatus::Paid;
            $order->update();

            // $customer = \Stripe\Customer::retrieve($session->customer);

            CartItem::where(['user_id' => $user->id])->delete();

            return view('checkout.success');
        }catch(Exception $e){
            return view('checkout.failure', ['message' => $e->getMessag()]);
        }
    }

    public function failure(Request $request)
    {
        \Stripe\Stripe::setApiKey(getenv('STRIPE_SECRET_KEY'));
        $session = \Stripe\Checkout\Session::retrieve($_GET['session_id']);
        $customer = \Stripe\Customer::retrieve($session->customer);

        return view('checkout.failure', compact('customer'));
    }
}
