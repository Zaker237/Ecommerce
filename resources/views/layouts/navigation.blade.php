<header x-data="{mobileMenuOpen: false}" class="flex justify-between bg-slate-800 text-white px-4">
    <div>
        <a class="block py-navbar-item" href="{{ route('home') }}"> Logo </a>
    </div>
    <!-- Mobile header -->
    <div class="block fixed z-20 top-0 bottom-0 h-full w-[220px] bg-slate-900 shadow-2xl transition-all md:hidden"
        :class="mobileMenuOpen ? 'left-0' : '-left-[220px]'">
        <ul>
            <li>
                <a class="flex items-center py-2 px-navbar-item transition-all hover:bg-slate-700"
					href="{{ route('home') }}">
                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5"
                        stroke="currentColor" class="w-5 h-5 mr-2">
                        <path stroke-linecap="round" stroke-linejoin="round"
                            d="M2.25 12l8.954-8.955c.44-.439 1.152-.439 1.591 0L21.75 12M4.5 9.75v10.125c0 .621.504 1.125 1.125 1.125H9.75v-4.875c0-.621.504-1.125 1.125-1.125h2.25c.621 0 1.125.504 1.125 1.125V21h4.125c.621 0 1.125-.504 1.125-1.125V9.75M8.25 21h8.25" />
                    </svg>
                    Home
                </a>
            </li>
            <li>
                <a class="block py-2 px-navbar-item transition-all hover:bg-slate-700" href="#">Categories</a>
            </li>
            <li>
                <a class="block py-2 px-navbar-item transition-all hover:bg-slate-700" href="#">Somethings</a>
            </li>
        </ul>
        <ul class="">
            <li>
                <a class="flex items-center justify-between py-2 px-navbar-item transition-all hover:bg-slate-700"
                    href="/src/cart.html">
                    <div class="flex items-center">
                        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5"
                            stroke="currentColor" class="w-6 h-6 mr-2">
                            <path stroke-linecap="round" stroke-linejoin="round"
                                d="M15.75 10.5V6a3.75 3.75 0 10-7.5 0v4.5m11.356-1.993l1.263 12c.07.665-.45 1.243-1.119 1.243H4.25a1.125 1.125 0 01-1.12-1.243l1.264-12A1.125 1.125 0 015.513 7.5h12.974c.576 0 1.059.435 1.119 1.007zM8.625 10.5a.375.375 0 11-.75 0 .375.375 0 01.75 0zm7.5 0a.375.375 0 11-.75 0 .375.375 0 01.75 0z" />
                        </svg>
                        Card
                    </div>
                    <small x-show="$store.header.cartItems" x-text="$store.header.cartItems" x-transition
                        class="py-[2px] px-[8px] rounded-full bg-red-500"></small>
                </a>
			</li>
			@if (!Auth::guest())
				<li x-data="{open: false}" class="relative">
					<a @click="open = !open"
						class="cursor-pointer flex justify-between items-center py-2 px-navbar-item transition-all hover:bg-slate-700">
						My Account
						<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5"
							stroke="currentColor" class="w-5 h-5 ml-2">
							<path stroke-linecap="round" stroke-linejoin="round" d="M19.5 8.25l-7.5 7.5-7.5-7.5" />
						</svg>
					</a>
					<ul x-show="open" x-transition class="w-full bg-slate-800 py-2">
						<li>
							<a class="flex items-center py-1 px-4 hover:bg-slate-700" href="/src/watchlist.html">
								<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5"
									stroke="currentColor" class="w-5 h-5 mr-2">
									<path stroke-linecap="round" stroke-linejoin="round"
										d="M21 8.25c0-2.485-2.099-4.5-4.688-4.5-1.935 0-3.597 1.126-4.312 2.733-.715-1.607-2.377-2.733-4.313-2.733C5.1 3.75 3 5.765 3 8.25c0 7.22 9 12 9 12s9-4.78 9-12z" />
								</svg>
								Watchlist
								<small x-show="$store.header.watchlistItems" x-text="$store.header.watchlistItems"
									x-transition class="py-[2px] px-[8px] rounded-full bg-red-500"></small>
							</a>
						</li>
						<li>
							<a class="flex items-center py-1 px-4 transition-all hover:bg-slate-700"
								href="/src/orders.html">
								<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5"
									stroke="currentColor" class="w-5 h-5 mr-2">
									<path stroke-linecap="round" stroke-linejoin="round"
										d="M19.5 12c0-1.232-.046-2.453-.138-3.662a4.006 4.006 0 00-3.7-3.7 48.678 48.678 0 00-7.324 0 4.006 4.006 0 00-3.7 3.7c-.017.22-.032.441-.046.662M19.5 12l3-3m-3 3l-3-3m-12 3c0 1.232.046 2.453.138 3.662a4.006 4.006 0 003.7 3.7 48.656 48.656 0 007.324 0 4.006 4.006 0 003.7-3.7c.017-.22.032-.441.046-.662M4.5 12l3 3m-3-3l-3 3" />
								</svg>
								Orders
							</a>
						</li>
						<li>
							<a class="flex items-center py-1 px-4 transition-all hover:bg-slate-700"
								href="/src/profile.html">
								<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5"
									stroke="currentColor" class="w-5 h-5 mr-2">
									<path stroke-linecap="round" stroke-linejoin="round"
										d="M15.75 6a3.75 3.75 0 11-7.5 0 3.75 3.75 0 017.5 0zM4.501 20.118a7.5 7.5 0 0114.998 0A17.933 17.933 0 0112 21.75c-2.676 0-5.216-.584-7.499-1.632z" />
								</svg>
								My Profile
							</a>
						</li>
						<li>
							<!-- Authentication -->
							<form method="POST" action="{{ route('logout') }}">
								@csrf
								<a
									class="flex items-center py-1 px-4 transition-all hover:bg-slate-700"
									href="{{ route('logout') }}
									onclick="event.preventDefault(); this.closest('form').submit();">
								>
									<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5"
										stroke="currentColor" class="w-5 h-5 mr-2">
										<path stroke-linecap="round" stroke-linejoin="round"
											d="M15.75 9V5.25A2.25 2.25 0 0013.5 3h-6a2.25 2.25 0 00-2.25 2.25v13.5A2.25 2.25 0 007.5 21h6a2.25 2.25 0 002.25-2.25V15M12 9l-3 3m0 0l3 3m-3-3h12.75" />
									</svg>
									{{ __('Log Out') }}
								</a>
							</form>
						</li>
					</ul>
				</li>
			@else
				<li class="my-3">
					<a class="flex items-center py-2 px-navbar-item transition-all hover:bg-slate-700"
						href="{{ route('login') }}">
						<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5"
							stroke="currentColor" class="w-6 h-6 mr-2">
							<path stroke-linecap="round" stroke-linejoin="round"
								d="M15.75 9V5.25A2.25 2.25 0 0013.5 3h-6a2.25 2.25 0 00-2.25 2.25v13.5A2.25 2.25 0 007.5 21h6a2.25 2.25 0 002.25-2.25V15m3 0l3-3m0 0l-3-3m3 3H9" />
						</svg>
						Login
					</a>
				</li>
				<li class="px-3">
					<a class="flex items-center btn-emerald" href="/src/signup.html">
						<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5"
							stroke="currentColor" class="w-6 h-6 mr-2">
							<path stroke-linecap="round" stroke-linejoin="round"
								d="M15.75 6a3.75 3.75 0 11-7.5 0 3.75 3.75 0 017.5 0zM4.501 20.118a7.5 7.5 0 0114.998 0A17.933 17.933 0 0112 21.75c-2.676 0-5.216-.584-7.499-1.632z" />
						</svg>
						Signup for Free
					</a>
				</li>
			</ul>
		@endif
    </div>
    <!--/ Mobile header -->
    <!-- Navbar -->
    <nav class="hidden md:block">
        <ul class="grid grid-flow-col">
            <li>
                <a class="flex items-center py-navbar-item px-navbar-item hover:bg-slate-700" href="{{ route('home') }}">
                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5"
                        stroke="currentColor" class="w-6 h-6 mr-2">
                        <path stroke-linecap="round" stroke-linejoin="round"
                            d="M2.25 12l8.954-8.955c.44-.439 1.152-.439 1.591 0L21.75 12M4.5 9.75v10.125c0 .621.504 1.125 1.125 1.125H9.75v-4.875c0-.621.504-1.125 1.125-1.125h2.25c.621 0 1.125.504 1.125 1.125V21h4.125c.621 0 1.125-.504 1.125-1.125V9.75M8.25 21h8.25" />
                    </svg>
                    Home
                </a>
            </li>
            <li>
                <a class="block py-navbar-item px-navbar-item hover:bg-slate-700" href="#">Categories</a>
            </li>
            <li>
                <a class="block py-navbar-item px-navbar-item hover:bg-slate-700" href="#">Somethings</a>
            </li>
        </ul>
    </nav>
    <nav class="hidden md:block">
        <ul class="grid grid-flow-col items-center">
            <li>
                <a class="relative flex items-center py-navbar-item px-navbar-item hover:bg-slate-700"
                    href="/src/cart.html">
                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5"
                        stroke="currentColor" class="w-6 h-6 mr-2">
                        <path stroke-linecap="round" stroke-linejoin="round"
                            d="M15.75 10.5V6a3.75 3.75 0 10-7.5 0v4.5m11.356-1.993l1.263 12c.07.665-.45 1.243-1.119 1.243H4.25a1.125 1.125 0 01-1.12-1.243l1.264-12A1.125 1.125 0 015.513 7.5h12.974c.576 0 1.059.435 1.119 1.007zM8.625 10.5a.375.375 0 11-.75 0 .375.375 0 01.75 0zm7.5 0a.375.375 0 11-.75 0 .375.375 0 01.75 0z" />
                    </svg>
                    Card
                    <small x-show="$store.header.cartItems" x-text="$store.header.cartItems" x-cloak x-transition
                        class=" absolute z-[100] py-[2px] px-[8px] top-4 -right-3 rounded-full bg-red-500"></small>
                </a>
			</li>
			@if (!Auth::guest())
				<li x-data="{open: false}" class="relative">
					<a @click="open = !open"
						class="cursor-pointer flex items-center py-navbar-item px-navbar-item hover:bg-slate-700">
						My Account
						<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5"
							stroke="currentColor" class="w-5 h-5 ml-2">
							<path stroke-linecap="round" stroke-linejoin="round" d="M19.5 8.25l-7.5 7.5-7.5-7.5" />
						</svg>
					</a>
					<ul @click.outside="open = false" x-show="open" x-transition x-cloak
						class="absolute z-10 w-36 bg-slate-800 right-0 py-2">
						<li>
							<a class="flex items-center justify-between py-2 px-3 hover:bg-slate-700"
								href="/src/watchlist.html">
								<div class="flex items-center">
									<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24"
										stroke-width="1.5" stroke="currentColor" class="w-5 h-5 mr-2">
										<path stroke-linecap="round" stroke-linejoin="round"
											d="M21 8.25c0-2.485-2.099-4.5-4.688-4.5-1.935 0-3.597 1.126-4.312 2.733-.715-1.607-2.377-2.733-4.313-2.733C5.1 3.75 3 5.765 3 8.25c0 7.22 9 12 9 12s9-4.78 9-12z" />
									</svg>
									Watchlist
								</div>
								<small x-show="$store.header.watchlistItems" x-text="$store.header.watchlistItems"
									x-transition class="py-[2px] px-[8px] rounded-full bg-red-500"></small>
							</a>
						</li>
						<li>
							<a class="flex items-center py-1 px-4 hover:bg-slate-700" href="/src/orders.html">
								<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5"
									stroke="currentColor" class="w-5 h-5 mr-2">
									<path stroke-linecap="round" stroke-linejoin="round"
										d="M19.5 12c0-1.232-.046-2.453-.138-3.662a4.006 4.006 0 00-3.7-3.7 48.678 48.678 0 00-7.324 0 4.006 4.006 0 00-3.7 3.7c-.017.22-.032.441-.046.662M19.5 12l3-3m-3 3l-3-3m-12 3c0 1.232.046 2.453.138 3.662a4.006 4.006 0 003.7 3.7 48.656 48.656 0 007.324 0 4.006 4.006 0 003.7-3.7c.017-.22.032-.441.046-.662M4.5 12l3 3m-3-3l-3 3" />
								</svg>
								Orders
							</a>
						</li>
						<li>
							<a class="flex items-center py-1 px-4 hover:bg-slate-700" href="/src/profile.html">
								<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5"
									stroke="currentColor" class="w-5 h-5 mr-2">
									<path stroke-linecap="round" stroke-linejoin="round"
										d="M15.75 6a3.75 3.75 0 11-7.5 0 3.75 3.75 0 017.5 0zM4.501 20.118a7.5 7.5 0 0114.998 0A17.933 17.933 0 0112 21.75c-2.676 0-5.216-.584-7.499-1.632z" />
								</svg>
								My Profile
							</a>
						</li>
						<li>
							<form method="POST" action="{{ route('logout') }}">
								@csrf
								<a class="flex items-center py-1 px-4 hover:bg-slate-700" href="{{ route('logout') }}">
									<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5"
										stroke="currentColor" class="w-5 h-5 mr-2">
										<path stroke-linecap="round" stroke-linejoin="round"
											d="M15.75 9V5.25A2.25 2.25 0 0013.5 3h-6a2.25 2.25 0 00-2.25 2.25v13.5A2.25 2.25 0 007.5 21h6a2.25 2.25 0 002.25-2.25V15M12 9l-3 3m0 0l3 3m-3-3h12.75" />
									</svg>
									{{ __('Log Out') }}
								</a>
							</form>
						</li>
					</ul>
				</li>
			@else
				<li>
					<a class="flex items-center py-navbar-item px-navbar-item hover:bg-slate-700" href="/src/login.html">
						<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5"
							stroke="currentColor" class="w-6 h-6 mr-2">
							<path stroke-linecap="round" stroke-linejoin="round"
								d="M15.75 9V5.25A2.25 2.25 0 0013.5 3h-6a2.25 2.25 0 00-2.25 2.25v13.5A2.25 2.25 0 007.5 21h6a2.25 2.25 0 002.25-2.25V15m3 0l3-3m0 0l-3-3m3 3H9" />
						</svg>
						Login
					</a>
				</li>
				<li>
					<a class="flex items-center btn-emerald" href="/src/signup.html">
						<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5"
							stroke="currentColor" class="w-6 h-6 mr-2">
							<path stroke-linecap="round" stroke-linejoin="round"
								d="M15.75 6a3.75 3.75 0 11-7.5 0 3.75 3.75 0 017.5 0zM4.501 20.118a7.5 7.5 0 0114.998 0A17.933 17.933 0 0112 21.75c-2.676 0-5.216-.584-7.499-1.632z" />
						</svg>
						Signup for Free
					</a>
				</li>
			@endif
        </ul>
    </nav>
    <!--/ Navbar -->
    <button @click="mobileMenuOpen = !mobileMenuOpen" class="p-4 block md:hidden">
        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor"
            class="w-6 h-6">
            <path stroke-linecap="round" stroke-linejoin="round"
                d="M3.75 5.25h16.5m-16.5 4.5h16.5m-16.5 4.5h16.5m-16.5 4.5h16.5" />
        </svg>
    </button>
</header>
