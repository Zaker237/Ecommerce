<x-guest-layout>
    <form method="POST" action="{{ route('register') }}">
        @csrf
        <div class="w-full sm:w-[400px] px-5 mx-auto mt-15 text-center">
            <h2 class="text-2xl font-semibold mb-2">Create new Account</h2>
            <p class="mb-4">or <a href="{{ route('login') }}" class="text-purple-600 hover:text-purple-500">Login with existing
                one</a>
            </p>
            <!-- Session Status -->
            <x-auth-session-status class="mb-4" :status="session('status')"/>

            <div class="mb-3">
                <x-input
                    type="text"
                    name="name"
                    :value="old('name')"
                    placeholder="Your Name"
                    class="w-full rounded border-gray-300"
                />
            </div>

            <div class="mb-3">
                <x-input
                    type="email"
                    placeholder="Your Email"
                    name="email"
                    :value="old('email')"
                    class="w-full rounded border-gray-300"
                />
            </div>

            <div class="mb-3">
                <x-input
                    type="password"
                    placeholder="Password"
                    name="password"
                    class="w-full rounded border-gray-300"
                />
            </div>

            <div class="mb-3">
                <x-input
                    type="password"
                    placeholder="Repeat Password"
                    name="password_repeat"
                    class="w-full rounded border-gray-300"
                />
            </div>

            <button class="flex items-center justify-center btn-emerald bg:bg-emerald-600 w-full mt-3">
                Signup
            </button>
        </div>
    </form>
</x-guest-layout>
