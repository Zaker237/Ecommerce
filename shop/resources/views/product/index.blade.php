<x-app-layout>
    <div class="grid grid-cols-1 gap-6 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 p-5">
        @foreach($products as $product)
            <!-- Product Item -->
                <div
                x-data="productItem({{ json_encode([
                    'id' => $product->id,
                    'image' => $product->image,
                    'title' => $product->title,
                    'price' => $product->price,
                    'addToCartUrl' => route('cart.add', $product),
                ]) }})"
                class="bg-white rounded-md overflow-hidden shadow border border-gray-300 transition-colors hover:border-purple-600"
            >
                <a href="{{ route('product.view', $product->slug) }}">
                    <img
                        class="rounded-t-md transition hover:scale-105 hover:rotate-1"
                        src="{{ $product->image }}"
                        alt=""
                    />
                </a>
                <div class="p-3">
                    <h3>
                        <a
                            class="text-black font-semibold hover:text-gray-600" 
                            href="{{ route('product.view', $product) }}"
                            >{{$product->title}}</a>
                    </h3>
                    <p class="text-xl font-bold">${{$product->price}}</p>
                    <div class="flex justify-between mt-3">
                        <!--<button
                            @click="addToWatchlist()"
                            class="flex items-center justify-center w-10 h-10 hover:text-white hover:bg-purple-700 rounded-full
                                        transition-colors border-2 border-purple-700 active:bg-purple-800"
                            :class="isInWatchlist() ? 'bg-purple-700 text-white' : 'text-purple-700'"
                        >
                            <svg
                                xmlns="http://www.w3.org/2000/svg"
                                fill="none"
                                viewBox="0 0 24 24"
                                stroke-width="1.5"
                                stroke="currentColor"
                                class="w-6 h-6"
                            >
                                <path
                                    stroke-linecap="round"
                                    stroke-linejoin="round"
                                    d="M21 8.25c0-2.485-2.099-4.5-4.688-4.5-1.935 0-3.597 1.126-4.312 2.733-.715-1.607-2.377-2.733-4.313-2.733C5.1 3.75 3 5.765 3 8.25c0 7.22 9 12 9 12s9-4.78 9-12z"
                                />
                            </svg>							
                        </button> -->
                        <button
                            @click="addToCart()"
                            class="flex items-center btn-primary"
                        >
                            <svg
                                xmlns="http://www.w3.org/2000/svg"
                                fill="none"
                                viewBox="0 0 24 24"
                                stroke-width="1.5"
                                stroke="currentColor"
                                class="w-6 h-6 mr-2"
                            >
                                <path
                                    stroke-linecap="round"
                                    stroke-linejoin="round"
                                    d="M2.25 3h1.386c.51 0 .955.343 1.087.835l.383 1.437M7.5 14.25a3 3 0 00-3 3h15.75m-12.75-3h11.218c1.121-2.3 2.1-4.684 2.924-7.138a60.114 60.114 0 00-16.536-1.84M7.5 14.25L5.106 5.272M6 20.25a.75.75 0 11-1.5 0 .75.75 0 011.5 0zm12.75 0a.75.75 0 11-1.5 0 .75.75 0 011.5 0z"
                                />
                            </svg>							
                            Add to Cart
                        </button>
                    </div>
                </div>
            </div>
            <!-- Product Item -->
        @endforeach
    </div>
    {{$products->links()}}
</x-app-layout>