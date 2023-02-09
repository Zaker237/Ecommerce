<x-app-layout>
    <div class="container mx-auto lg:w-2/3 p-5">
        <h1 class="text-xl font-bold mb-2">My Orders</h1>
        <div class="bg-white rounded-lg p-3 overflow-x-auto">
            <table class="table-auto w-full">
                <thead>
                    <tr class="border-b-2">
                        <th class="text-left p-2">Order #</th>
                        <th class="text-left p-2">Date</th>
                        <th class="text-left p-2">Status</th>
                        <th class="text-left p-2">Subtotal</th>
                        <th class="text-left p-2 whitespace-nowrap">Items</th>
                        <th class="text-left p-2">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    @foreach ($orders as $order)
                        <tr class="border-b">
                            <td class="py-1 px-2">
                                <a class="text-purple-600 hover:text-purple-600"
                                    href="{{ route('order.view', $order) }}">
                                    #{{ $order->id }}
                                </a>
                            </td>
                            <td class="py-1 px-2 whitespace-nowrap">{{ $order->created_at }}</td>
                            <td class="py-1 px-2">
                                <span
                                    class="py-1 px-2 rounded
                            {{ $order->isPaid() ? 'bg-emerald-500' : 'bg-gray-400' }} text-white">{{ $order->status }}</span>
                            </td>
                            <td class="py-1 px-2">${{ $order->total_price }}</td>
                            <td class="py-1 px-2">{{ $order->Items->count() }} items(s)</td>
                            <td class="flex gap-2 py-1 px-2">
                                <div x-data="{
                            open: false,
                            accept() {
                            console.log('accepted')
                            }
                        }">
                                    <button @click="open = true"
                                        class="flex items-center btn-emerald whitespace-nowrap">
                                        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24"
                                            stroke-width="1.5" stroke="currentColor" class="w-5 h-5 mr-2">
                                            <path stroke-linecap="round" stroke-linejoin="round"
                                                d="M19.5 14.25v-2.625a3.375 3.375 0 00-3.375-3.375h-1.5A1.125 1.125 0 0113.5 7.125v-1.5a3.375 3.375 0 00-3.375-3.375H8.25m0 12.75h7.5m-7.5 3H12M10.5 2.25H5.625c-.621 0-1.125.504-1.125 1.125v17.25c0 .621.504 1.125 1.125 1.125h12.75c.621 0 1.125-.504 1.125-1.125V11.25a9 9 0 00-9-9z" />
                                        </svg>
                                        Invoice
                                    </button>
                                    <template x-teleport="body">
                                        <!-- Backdrop -->
                                        <div x-show="open"
                                            class="fixed flex justify-center items-center left-0 top-0 bottom-0 right-0 z-10 bg-black/50">
                                            <!-- Dialog -->
                                            <div x-show="open" x-transition @click.outside="open = false"
                                                class="w-[90%] md:w-1/2 bg-white rounded-lg">
                                                <!-- Modal Title -->
                                                <div
                                                    class="py-2 px-4 text-lg font-semibold bg-gray-100 rounded-t-lg flex items-center justify-between">
                                                    <h2>Modal Title</h2>
                                                    <button @click="open = false">
                                                        <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6"
                                                            fill="none" viewBox="0 0 24 24" stroke="currentColor"
                                                            stroke-width="2">
                                                            <path stroke-linecap="round" stroke-linejoin="round"
                                                                d="M6 18L18 6M6 6l12 12" />
                                                        </svg>
                                                    </button>
                                                </div>
                                                <!-- Modal Body -->
                                                <div class="p-4">Invoice content</div>
                                                <!-- Modal Footer -->
                                                <div
                                                    class="py-2 px-4 text-lg flex justify-end font-semibold bg-gray-100 rounded-b-lg">
                                                    <button @click="open = false"
                                                        class="inline-flex items-center py-1 px-3 bg-gray-300 hover:bg-opacity-95 text-gray-800 rounded-md shadow">
                                                        Close
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
                                    </template>
                                </div>
                                @if (!$order->isPaid())
                                    <form action="{{ route('checkout.order', $order) }}" method="POST">
                                        @csrf
                                        <button type="submit" class="flex py-1 items-center btn-primary whitespace-nowrap">
                                            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24"
                                                stroke-width="1.5" stroke="currentColor" class="w-5 h-5 mr-2">
                                                <path stroke-linecap="round" stroke-linejoin="round"
                                                d="M2.25 8.25h19.5M2.25 9h19.5m-16.5 5.25h6m-6 2.25h3m-3.75 3h15a2.25 2.25 0 002.25-2.25V6.75A2.25 2.25 0 0019.5 4.5h-15a2.25 2.25 0 00-2.25 2.25v10.5A2.25 2.25 0 004.5 19.5z" />
                                            </svg>
                                            Pay
                                        </button>
                                    </form>
                                @endif
                            </td>
                        </tr>
                    @endforeach
                </tbody>
            </table>
        </div>
        <div class="mt-3">
            {{$orders->links()}}
        </div>
    </div>
</x-app-layout>
