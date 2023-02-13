<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Symfony\Component\HttpKernel\Exception\NotFoundHttpException;

use App\Http\Helpers\Cart;
use App\Enums\OrderStatus;
use App\Enums\PaymentStatus;
use App\Models\Order;
use App\Models\OrderItem;
use App\Models\Payment;
use App\Models\CartItem;

class CheckoutController extends Controller
{
    public function checkout(Request $request){
        $user = $request->user();
        \Stripe\Stripe::setApiKey(getenv('STRIPE_SECRET_KEY'));

        list($products, $cartItems) = Cart::getProductsAndCartItems();

        $orderItems = [];
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
            $orderItems[] = [
                'product_id' => $product->id,
                'quantity' => $quantity,
                'unit_price' => $product->price
            ];
        }

        $checkout_session = \Stripe\Checkout\Session::create([
            'line_items' => $lineItems,
            'mode' => 'payment',
            'success_url' => route('checkout.success', [], true).'?session_id='.'{CHECKOUT_SESSION_ID}',
            'cancel_url' => route('checkout.failure', [], true),
        ]);

        // create Order

        $orderData = [
            'total_price' => $totalPrice,
            'status' => OrderStatus::Unpaid,
            'created_by' => $user->id,
            'updated_by' => $user->id,
        ];
        $order = Order::create($orderData);

        // create oders items

        foreach($orderItems as $orderItem){
            $orderItem['order_id'] = $order->id;
            OrderItem::create($orderItem);
        }

        // create payment
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
        CartItem::where(['user_id' => $user->id])->delete();
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
            $payment = Payment::query()
            ->where(['session_id' => $session_id])
            ->whereIn('status', [PaymentStatus::Pending, PaymentStatus::Paid])
            ->first();
            if (!$payment || $payment->status != PaymentStatus::Pending){
                throw New NotFoundHttpException();
            }
            if($payment->status == PaymentStatus::Pending)
            {
                $this->updateOrderAndSession($payment);
            }
            // $customer = \Stripe\Customer::retrieve($session->customer);

            return view('checkout.success');
        }catch(NotFoundHttpException $e){
            throw $e;
        }catch(Exception $e){
            return view('checkout.failure', ['message' => $e->getMessag()]);
        }
    }

    public function failure(Request $request)
    {
        return view('checkout.failure', ['message' => 'Your Payment was not successfull!!']);
    }

    public function checkoutOrder(Order $order, Request $request)
    {
        $user = $request->user();
        \Stripe\Stripe::setApiKey(getenv('STRIPE_SECRET_KEY'));

        $lineItems = [];

        foreach($order->items as $item){
            $lineItems[] = [
                'price_data' => [
                    'currency' => 'usd',
                    'product_data' => [
                        'name' => $item->product->title,
                        'images' => [$item->product->image],
                    ],
                    'unit_amount' => $item->unit_price * 100,
                ],
                'quantity' => $item->quantity,
            ];
        }

        $checkout_session = \Stripe\Checkout\Session::create([
            'line_items' => $lineItems,
            'mode' => 'payment',
            'success_url' => route('checkout.success', [], true).'?session_id='.'{CHECKOUT_SESSION_ID}',
            'cancel_url' => route('checkout.failure', [], true),
        ]);

        $order->payment->session_id = $checkout_session->id;
        $order->payment->save();

        return redirect($checkout_session->url);
    }

    public function webhook(Request $request)
    {
        $user = $request->user();
        \Stripe\Stripe::setApiKey(getenv('STRIPE_SECRET_KEY'));

        $endpoint_secret = 'whsec_092eaa533659a71ceafc352e829499bde9cbd73d12b348c613e1b64badd1d429';

        $payload = @file_get_contents('php://input');
        $sig_header = $_SERVER['HTTP_STRIPE_SIGNATURE'];
        $event = null;

        try {
            $event = \Stripe\Webhook::constructEvent(
                $payload, $sig_header, $endpoint_secret
            );
        } catch(\UnexpectedValueException $e) {
            // Invalid payload
            return response('', 401);
        } catch(\Stripe\Exception\SignatureVerificationException $e) {
            // Invalid signature
            return response('', 402);
        }

        // Handle the event
        switch ($event->type) {
            case 'checkout.session.completed':
                $paymentIntent = $event->data->object;
                $sessionId = $paymentIntent['id'];
                $payment = Payment::query()
                ->where(['session_id' => $sessionId, 'status' => PaymentStatus::Pending])
                ->first();
                if($payment)
                {
                    $this->updateOrderAndSession($payment);
                }

            default:
            echo 'Received unknown event type ' . $event->type;
        }

        return response('', 200);
    }

    private function updateOrderAndSession(Payment $payment)
    {
        $payment->status = PaymentStatus::Paid;
        $payment->update();

        $order = $payment->order;
        $order->status = OrderStatus::Paid;
        $order->update();
    }
}
