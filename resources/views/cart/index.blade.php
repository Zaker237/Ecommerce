<x-app-layout>
    <div class="container mx-auto lg:w-2/3 p-5">
        <h1 class="text-xl font-bold mb-2">My Cart Items</h1>
        <div x-data="
            {
                cartItems: {{ json_encode(
                    $products->map(
                        fn($product) => [
                            'id' => $product->id,
                            'slug' => $product->slug,
                            'image' => $product->image,
                            'title' => $product->title,
                            'price' => $product->price,
                            'quantity' => $cartItems[$product->id]['quantity'],
                            'href' => route('product.view', $product),
                            'removeFromCartUrl' => route('cart.remove', $product),
                            'updateQuantityUrl' => route('cart.update-quantity', $product),
                        ],
                    ),
                ) }},
                get total() {
                    return this.cartItems.reduce((acc, next) => {return acc + next.price*next.quantity}, 0).toFixed(2);
                }
            }" class="bg-white rounded-lg p-3">
            <template x-if="cartItems.length">
                <div>
                    <template x-for="product of cartItems" :key="product.id">
                        <div x-data="productItem(product)">
                            <!-- Cart Item -->
                            <div class="flex flex-col items-center w-full flex-1 gap-4 sm:flex-row">
                                <a
                                    :href="product.href"
                                    class="w-36 h-32 flex items-center justify-center overflow-hidden"
                                >
                                    <img :src="product.image" class="object-cover" alt="" />
                                </a>
                                <div class="flex flex-col flex-1 justify-between">
                                    <div class="flex justify-between mb-3">
                                        <h3 x-text="product.title"></h3>
                                        <span class="text-lg font-semibold">$<span x-text="product.price"></span></span>
                                    </div>
                                    <div class="flex justify-between items-center">
                                        <!-- Input Group-->
                                        <div class="flex items-center">
                                            Quantity:
                                            <input
                                                type="number"
                                                min="1"
                                                name="quantity"
                                                x-model="product.quantity"
                                                @change="changeQuantity()"
                                                class="ml-3 py-1 border-gray-200 focus:border-purple-600 focus:ring-purple-600 w-16"
                                            />
                                        </div>
                                        <a @click.prevent="removeItemFromCart()"
                                            class="text-purple-600 hover:text-purple-500" href="#">
                                            Remove
                                        </a>
                                        <!--/ Input Group -->
                                    </div>
                                </div>
                            </div>
                            <!--/ Cart Item -->
                            <hr class="mt-5 pb-2 pt-2" />
                        </div>
                    </template>
                    <div class="">
                        <div class="flex justify-between">
                            <span class="font-bold">Subtotal</span>
                            <span class="font-bold">$<span x-text="total"></span>
                        </div>
                        <p>Shipping and tax will be applied on checkout</p>
                    </div>
                    <form action="{{ route('cart.checkout') }}" method="POST">
                        @csrf
                        <button type="submit" class="btn-primary w-full mt-3">Checkout</button>
                    </form>
                </template>
                <template x-if="!cartItems.length">
                    <div class="text-center py-8 text-gray-500">
                        You don't have any items in cart
                    </div>
                </template>
            </div>
        </div>
    </div>
</x-app-layout>
