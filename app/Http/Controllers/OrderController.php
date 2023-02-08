<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Order;

class OrderController extends Controller
{
    public function index(Request $request)
    {
        $user = $request->user();
        $orders = Order::query()->where(['created_by' => $user->id])->paginate(20);

        return view('order.index', compact('orders'));
    }

    public function view(Request $request)
    {

    }
}
