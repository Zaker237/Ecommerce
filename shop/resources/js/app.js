import './bootstrap';
import Alpine from 'alpinejs';
import collapse from '@alpinejs/collapse';

import { post } from './http'

Alpine.plugin(collapse);
window.Alpine = Alpine;

document.addEventListener('alpine:init', () => {
	/*Alpine.store('header', {
		//cartItems: Alpine.$persist(0),
		cartItemsObject: {},
		watchingItems: [],
		get watchlistItems() {
			return this.watchingItems.length;
		},
		get cartItems() {
			return Object.values(this.cartItemsObject).reduce(
				(acc, next) => { return acc + parseInt(next.quantity) }, 0
			);
		},
	}); */

	Alpine.data('toast', () => ({
		visible: false,
		delay: 5000,
		percent: 0,
		interval: null,
		timeout: null,
		message: null,
		close() {
			this.visible = false;
			clearInterval(this.interval);
		},
		show(message) {
			this.visible = true;
			this.message = message;

			if (this.interval) {
				clearInterval(this.interval);
				this.interval = null;
			}

			if (this.timeout) {
				clearTimeout(this.timeout);
			}

			this.timeout = setTimeout(() => {
				this.visible = false;
				this.timeout = null;
			}, this.delay);
			const startDate = Date.now();
			const futureDate = Date.now() + this.delay;
			this.interval = setInterval(() => {
				const date = Date.now();
				this.percent = (date - startDate) * 100 / (futureDate - startDate);
				if (this.percent >= 100) {
					clearInterval(this.interval);
					this.interval = null;
				}
			}, 30)
		},
	}));

	Alpine.data('productItem', (product) => ({
		//id: product.id,
		product: product,
		//quantity: 1,
		get watchlistItems() {
			return this.$store.header.watchlistItems;
		},
		addToCart(quantity = 1) {
			console.log(this.product);
			post(this.product.addToCartUrl, {quantity})
				.then(result => {
					this.$dispatch('cart-change', {count: result.count});
					this.$dispatch('notify', {
						message: 'The item was added into the cart',
					});
				})
				.catch(response =>{
					console.log(response);
				});
		},
		/*addToWatchlist() {
			if (this.isInWatchlist()) {
				this.$store.header.watchingItems.splice(
					this.$store.header.watchingItems.findIndex((p) => p.id === product.id),
					1
				);
				this.$dispatch('notify', {
					message: 'The item was removed into the watchlist'
				});
				// this.$store.toast.show('The item was removed into the watchlist');
			} else {
				this.$store.header.watchingItems.push(product);
				this.$dispatch('notify', {
					message: 'The item was added into the watchlist'
				});
				// this.$store.toast.show('The item was added into the watchlist');
			}
			console.log(this.$store.header.watchingItems)
		},
		isInWatchlist() {
			return this.$store.header.watchingItems.find((p) => { return p.id === product.id });
		},*/
		removeItemFromCart() {
			post(this.product.removeFromCartUrl)
				.then(result => {
					this.$dispatch('notify', {
						message: 'The item was removed from cart',
					});
					this.$dispatch('cart-change', {count: result.count});
					this.cartItems = this.cartItems.filter(p => p.id !== product.id);
				})
				.catch(response =>{
					console.log(response);
				});
		},
		changeQuantity() {
			post(this.product.updateQuantityUrl, {quantity: product.quantity})
				.then(result => {
					this.$dispatch('cart-change', {count: result.count});
					this.$dispatch('notify', {
						message: 'The item quantity was updated',
					});
				})
				.catch(response =>{
					console.log(response);
				});
		},
	}));

	/*Alpine.data('signupForm', () => ({
		defaultClasses: 'focus:border-purple-600 focus:ring-purple-600 focus:outline-none',
		errorClasses: 'border-red-500 focus:border-red-500 focus:ring-red-500 ring-red-600 ring-1',
		successClasses: 'border-emerald-500 focus:border-emerald-500 focus:ring-emerald-500 ring-green-600 ring-1',
		form: {
			name: '',
			email: '',
			password: '',
			password_repeat: ''
		},
		errors: {
			name: '',
			email: '',
			password: '',
			password_repeat: ''
		},
		submit() {
			this.validateName();
			this.validateEmail();
			this.validatePassword();
			this.validatePasswordRepeat();
		},
		validateName() {
			this.errors.name = '';
			if (!this.form.name) {
				this.errors.name = 'This Field is required';
			} else if (this.form.name.length < 2) {
				this.errors.name = 'This Name should be at least 2 Characters';
			}
		},
		validateEmail() {
			this.errors.email = '';
			if (!this.form.email) {
				this.errors.email = 'This Field is required';
			} else if (!this.validateEmailWithRegex()) {
				this.errors.email = 'This must be a valid email';
			}
		},
		validateEmailWithRegex() {
			return String(this.form.email)
				.toLowerCase()
				.match(
					/^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/
				);
		},
		validatePassword(){
			this.errors.password = '';
			if (!this.form.password) {
				this.errors.password = 'This Field is required';
			}
		},
		validatePasswordRepeat(){
			this.errors.password_repeat = '';
			if (!this.form.password_repeat) {
				this.errors.password_repeat = 'This Field is required';
			} else if (this.form.password_repeat !== this.form.password) {
				this.errors.password_repeat = 'This repeat Password should be the same as the passwords';
			}
		},
	}))*/
});

Alpine.start();