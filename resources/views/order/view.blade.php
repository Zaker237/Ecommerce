<x-app-layout>
    <div class="container mx-auto lg:w-2/3 p-5">
        <h1 class="text-xl font-bold mb-2">Orders #{{ $order->id }}</h1>
        <div class="bg-white rounded-lg p-3">
            <table>
                <tbody>
                    <tr>
                        <td class="font-bold py-1 px-2">Order #</td>
                        <td>{{ $order->id }}</td>
                    </tr>
                    <tr>
                        <td class="font-bold py-1 px-2">Order Date</td>
                        <td>{{ $order->created_at }}</td>
                    </tr>
                    <tr>
                        <td class="font-bold py-1 px-2">Order Status</td>
                        <td>
                            <span
                                class="{{ $order->isPaid() ? 'bg-emerald-500' : 'bg-gray-400' }} py-1 px-2 rounded text-white">
                                {{ $order->status }}
                            </span>
                        </td>
                    </tr>
                    <tr>
                        <td class="font-bold py-1 px-2">Subtotal</td>
                        <td>${{ $order->total_price }}</td>
                    </tr>
                </tbody>
            </table>
            <hr class="my-5" />
            @foreach ($order->items as $item)
                <!-- Order Item -->
                <div class="flex flex-col items-center gap-4 flex-1 sm:flex-row">
                    <a href="{{ route('product.view', $item->product) }}"
                        class="w-36 h-32 flex items-center justify-center overflow-hidden">
                        <img src="{{ $item->product->image }}" class="object-covert" alt="" />
                    </a>
                    <div class="flex flex-col flex-1 justify-between">
                        <div class="flex justify-between mb-3">
                            <h3>{{ $item->product->title }}</h3>
                            <span class="text-lg font-semibold">${{ $item->unit_price }}</span>
                        </div>
                        <div class="flex justify-between items-center">
                            <!-- Input Group-->
                            <div class="flex items-center">Quantity: {{ $item->quantity }}</div>
                            <!--/ Input Group -->
                        </div>
                    </div>
                </div>
                <!--/ Order Item -->
                <hr class="my-5" />
            @endforeach
            @if (!$order->isPaid())
                <form action="{{ route('checkout.order', $order) }}" method="POST">
                    @csrf
                    <button type="submit" class="flex items-center justify-center btn-primary w-full mt-3 whitespace-nowrap">
                        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5"
                            stroke="currentColor" class="w-5 h-5 mr-2">
                            <path stroke-linecap="round" stroke-linejoin="round"
                                d="M2.25 8.25h19.5M2.25 9h19.5m-16.5 5.25h6m-6 2.25h3m-3.75 3h15a2.25 2.25 0 002.25-2.25V6.75A2.25 2.25 0 0019.5 4.5h-15a2.25 2.25 0 00-2.25 2.25v10.5A2.25 2.25 0 004.5 19.5z" />
                        </svg>
                        Make a Payment
                    </button>
                </form>
            @endif
        </div>
    </div>
</x-app-layout>
