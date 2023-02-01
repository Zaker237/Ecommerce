<x-app-layout>
    <form method="POST" action="{{ route('login') }}" class="w-full sm:w-[400px] px-5 mx-auto mt-15 text-center">
        <h2 class="text-2xl font-semibold mb-2">Login o your account</h2>
        <p class="mb-4">
            or
            <a
                href="{{ route('register') }}"
                class="text-purple-600 hover:text-purple-500"
            >
                create new account
            </a>
        </p>

        <!-- Session Status -->
        <x-auth-session-status class="mb-4" :status="session('status')"/>

        @csrf
        <div class="mb-3">
            <x-input type="email" name="email" placeholder="Your email address" :value="old('email')"/>
        </div>
        <div class="mb-3">
            <x-input type="password" name="password" placeholder="Your password" :value="old('password')" />
        </div>
        <div class="flex justify-between mb-3">
            <div class="flex items-center">
                <input
                    id="loginRememberMe"
                    type="checkbox"
                    class="text-purple-600 focus:ring-purple-600 mr-2"
                />
                <label for="loginRememberMe" class="text-gray-700">Remember Me</label>
            </div>
            @if (Route::has('password.request'))
                <a href="{{ route('password.request') }}" class="text-purple-600 hover:text-purple-500">
                    Forgot Password?
                </a>
            @endif
        </div>
        <button
            class="flex items-center justify-center btn-emerald bg:bg-emerald-600 w-full mt-3"
        >
            Login
        </button>
    </form>
</x-app-layout>