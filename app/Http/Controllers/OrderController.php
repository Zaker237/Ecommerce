<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Validation\UnauthorizedException;
use App\Models\Order;

class OrderController extends Controller
{
    public function index(Request $request)
    {
        $user = $request->user();
        $orders = Order::query()
        ->where(['created_by' => $user->id])
        ->orderBy('created_at', 'desc')
        ->paginate(10);

        return view('order.index', compact('orders'));
    }

    public function view(Order $order)
    {
        $user = request()->user();
        if ($order->created_by !== $user->id)
        {
            return response("You don't have permission to view this order", 403);
        }
        return view('order.view', compact('order'));
    }
}
