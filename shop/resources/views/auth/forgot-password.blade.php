<x-guest-layout>
    <form action="{{ route('password.email') }}" method="POST">
        @csrf
        <div class="w-full sm:w-[400px] px-5 mx-auto mt-15 text-center">
        <h2 class="text-2xl font-semibold mb-2">Enter your Email to reset your password</h2>
        <p class="mb-4">or <a href="{{ route('login') }}" class="text-purple-600 hover:text-purple-500">Login with existing account</a></p>
            <div class="mb-3">
                <input
                    type="email"
                    placeholder="Your Email"
                    class="w-full rounded border-gray-300 focus:border-purple-600 focus:ring-purple-600"
                />
            </div>
            <button class="flex items-center justify-center btn-emerald bg:bg-emerald-600 w-full mt-3">
                Submit
            </button>
        </div>
    </form>
</x-guest-layout>
