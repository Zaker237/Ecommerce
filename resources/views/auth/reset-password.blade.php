<x-guest-layout>
    <!-- Validation Errors -->
    <x-auth-validation-errors class="mb-4" :errors="$errors" />

    <form method="POST" action="{{ route('password.update') }}">
        @csrf
        <div class="w-full sm:w-[400px] px-5 mx-auto mt-15 text-center">
            <h2 class="text-2xl font-semibold mb-2">Reset your password</h2>
            <!-- Password Reset Token -->
            <input type="hidden" name="token" value="{{ $request->route('token') }}">

            <!-- Email Address -->
            <div class="mb-3">
                <x-input
                    id="email"
                    class="w-full rounded border-gray-300 focus:border-purple-600 focus:ring-purple-600"
                    type="email"
                    name="email"
                    :value="old('email', $request->email)"
                    required
                    autofocus
                />
            </div>

            <!-- Password -->
            <div class="mb-3">
                <x-input
                    id="password"
                    class="w-full rounded border-gray-300 focus:border-purple-600 focus:ring-purple-600"
                    type="password"
                    name="password"
                    required
                />
            </div>

            <!-- Confirm Password -->
            <div class="mb-3">
                <x-input
                    id="password_confirmation"
                    class="w-full rounded border-gray-300 focus:border-purple-600 focus:ring-purple-600"
                    type="password"
                    name="password_confirmation"
                    required
                />
            </div>

            <x-button class="flex items-center justify-center btn-emerald bg:bg-emerald-600 w-full mt-3">>
                {{ __('Reset Password') }}
            </x-button>
        </div>
    </form>
</x-guest-layout>
