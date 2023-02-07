<?php
/** User. Zaker*/

namespace App\Http\Helpers;

use Illuminate\Support\Arr;

use App\Models\CartItem;
use App\Models\Product;

/**
 * Class Cart
 * 
 * @author Alex
 * @package App\Http\Helpers
 */

class Cart
{
    public static function getCartItemsCount(): int
    {
        $request = \request();
        $user = $request->user();

        if($user){
            return CartItem::where(['user_id' => $user->id])->sum('quantity');
        }else{
            $cartItems = self::getCookiesCartItems();

            return array_reduce(
                $cartItems,
                fn($total, $item) => $total + $item['quantity'],
                0
            );
        }
    }

    public static function getCartItems()
    {
        $request = \request();
        $user = $request->user();

        if($user){
            return CartItem::where(['user_id' => $user->id])->get()->map(
                fn($item) => ['product_id' => $item->product_id, 'quantity' => $item->quantity]
            );
        }else{
            return self::getCookiesCartItems();
        }
    }

    public static function getCookiesCartItems()
    {
        $request = \request();

        return \json_decode($request->cookie('cart_items', '[]'), true);
    }

    public static function getCountFromCartItems($cartItems)
    {
        return array_reduce(
            $cartItems,
            fn($total, $item) => $total + $item['quantity'],
            0
        );
    }

    public static function moveCartItemsIntoDb()
    {
        $request = \request();
        $cartItems = self::getCookiesCartItems();
        $dbCartItems = CartItem::where(['user_id' => $request->user()->id])->get()->keyBy('product_id');
        $newCartItems = [];

        foreach($cartItems as $cartItem){
            if(isset($dbCartItems[$cartItem['product_id']])){
                continue;
            }else{
                $newCartItems[] = [
                    'user_id' => $request->user()->id,
                    'product_id' => $cartItem['product_id'],
                    'quantity' => $cartItem['quantity'],
                ];
            }
        }

        if(!empty($newCartItems)){
            CartItem::insert($newCartItems);
        }
    }

    public static function getProductsAndCartItems()
    {
        $cartitems = self::getCartItems();
        $ids = Arr::pluck($cartitems, 'product_id');
        $products = Product::query()->whereIn('id', $ids)->get();
        $cartItems = Arr::keyBy($cartitems, 'product_id');

        return [$products, $cartItems];
    }
}
