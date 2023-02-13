<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Cookie;
use Illuminate\Support\Arr;

use App\Models\Product;
use App\Models\CartItem;
use App\Http\Helpers\Cart;
use Stripe\Stripe;

class CartController extends Controller
{
    public function index(){
        list($products, $cartItems) = Cart::getProductsAndCartItems();
        $total = 0;
        foreach($products as $product){
            $total += $product->price * $cartItems[$product->id]['quantity'];
        }

        return view('cart.index', compact('cartItems', 'products', 'total'));
    }

    public function add(Request $request, Product $product){
        $quantity = $request->post('quantity', 1);
        $user = $request->user();
        if ($user){
            $cartitem = CartItem::where(['user_id' => $user->id, 'product_id' => $product->id])->first();

            if ($cartitem){
                $cartitem->quantity += $quantity;
                $cartitem->update();
            }else{
                $data = [
                    'user_id' => $request->user()->id,
                    'product_id' => $product->id,
                    'quantity' => $quantity,
                ];
                CartItem::create($data);
            }

            return response([
                'count' => Cart::getCartItemsCount()
            ]);
        }else{
            $cartitems = json_decode($request->cookie('cart_items', '[]'), true);
            $productFound = false;
            foreach($cartitems as &$item){
                if($item['product_id'] === $product->id){
                    $item['quantity'] += $quantity;
                    $productFound = true;
                    break;
                }
            }
            
            if(!$productFound){
                $cartitems[] = [
                    'user_id' => null,
                    'product_id' => $product->id,
                    'quantity' => $quantity,
                    'price' => $product->price,
                ];

            }
            Cookie::queue('cart_items', json_encode($cartitems), 60*24*30);
            return response([
                'count' => Cart::getCountFromCartItems($cartitems)
            ]);
        }
    }

    public function remove(Request $request, Product $product){
        $user = $request->user();
        if($user){
            $cartitem = CartItem::where(['user_id' => $user->id, 'product_id' => $product->id])->first();
            if ($cartitem){
                $cartitem->delete();
            }
            return response([
                'count' => Cart::getCartItemsCount()
            ]);
        }else{
            $cartitems = json_decode($request->cookie('cart_items', '[]'), true);

            foreach($cartitems as $i=>&$item){
                if($item['product_id'] === $product->id){
                    array_splice($cartitems, $i, 1);
                    break;
                }
            }

            Cookie::queue('cart_items', json_encode($cartitems), 60*24*30);
            return response([
                'count' => Cart::getCountFromCartItems($cartitems)
            ]);
        }
    }

    public function updateQuantity(Request $request, Product $product){
        $quantity = $request->post('quantity', 1);
        $user = $request->user();
        if ($user){
            CartItem::where(['user_id' => $user->id, 'product_id' => $product->id])
            ->update(['quantity' => $quantity]);

            return response([
                'count' => Cart::getCartItemsCount()
            ]);
        }else{
            $cartitems = json_decode($request->cookie('cart_items', '[]'), true);

            foreach($cartitems as &$item){
                if($item['product_id'] === $product->id){
                    $item['quantity'] = $quantity;
                    break;
                }
            }

            Cookie::queue('cart_items', json_encode($cartitems), 60*24*30);
            return response([
                'count' => Cart::getCountFromCartItems($cartitems)
            ]);
        }
    }
}