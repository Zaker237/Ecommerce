import { defineStore, acceptHMRUpdate } from "pinia";
import {
	RootDashboardState,
} from "../types/dashboard";
import currencyUSD from "../filters/curency";
import axios from "axios";
import { useUserStore } from "./user.store";
const API_BASE_URL = import.meta.env.VITE_API_BASE_URL;

export const useDashboardStore = defineStore({
	id: "dashboard",
	state: () => ({
		customerNumber: 0,
		productNumber: 0,
		paidOrderNumber: 0,
		totalIncomeNumber: 0,
		orders: [],
		countryOrders: [],
		customers: [],
		customersCountLoading: false,
		productsCountLoading: false,
		paidOrdersLoading: false,
		totalIncomeLoading: false,
		ordersByCountryLoading: false,
		latestCustomers: false,
		latestOrdersLoading: false,
		error: null
	} as RootDashboardState),

	getters: {
		customerCount: (state) => state.customerNumber,
		productCount: (state) => state.productNumber,
		paidOrderCount: (state) => state.paidOrderNumber,
		totalIncomeCount: (state) => state.totalIncomeNumber,
		latestCustomers: (state) => state.customers,
		latestOrders: (state) => state.orders,
		OrdersByCountry: (state) => state.countryOrders,
		loadingCustomersCount: (state) => state.customersCountLoading,
		loadingProductsCount: (state) => state.productsCountLoading,
		loadingPaidOrders: (state) => state.paidOrdersLoading,
		LoadingTotalIncome: (state) => state.totalIncomeLoading,
		LoadingOrdersByCountry: (state) => state.ordersByCountryLoading,
	},
	actions: {
		async getCustomerCount() {
			this.customersCountLoading = true;
			try {
				const { data, status } = await axios.get(
					`${API_BASE_URL}/dashboard/customers-count`,
					{
						headers: {
							"Content-Type": "application/json",
							"Authorization": `Bearer ${useUserStore().token}`
						},
					},
				);
				this.customerNumber = data.data;
			} catch (error) {
				if (axios.isAxiosError(error)) {
					this.error = error.message;
				} else {
					this.error = "An unexpected error occurred";
				}
			} finally {
				this.customersCountLoading = false;
			}
		},

		async getProductCount() {
			this.productsCountLoading = true;
			try {
				const { data, status } = await axios.get(
					`${API_BASE_URL}/dashboard/products-count`,
					{
						headers: {
							"Content-Type": "application/json",
							"Authorization": `Bearer ${useUserStore().token}`
						},
					},
				);
				this.productNumber = data.data;
			} catch (error) {
				if (axios.isAxiosError(error)) {
					this.error = error.message;
				} else {
					this.error = "An unexpected error occurred";
				}
			} finally {
				this.productsCountLoading = false;
			}
		},

		async getOrderCount() {
			this.ordersByCountryLoading = true;
			try {
				const { data, status } = await axios.get(
					`${API_BASE_URL}/dashboard/orders-count`,
					{
						headers: {
							"Content-Type": "application/json",
							"Authorization": `Bearer ${useUserStore().token}`
						},
					},
				);
				this.paidOrderNumber = data.data;
			} catch (error) {
				if (axios.isAxiosError(error)) {
					this.error = error.message;
				} else {
					this.error = "An unexpected error occurred";
				}
			} finally {
				this.ordersByCountryLoading = false;
			}
		},

		async getTotalIncome() {
			this.totalIncomeLoading = true;
			try {
				const { data, status } = await axios.get(
					`${API_BASE_URL}/dashboard/income-amount`,
					{
						headers: {
							"Content-Type": "application/json",
							"Authorization": `Bearer ${useUserStore().token}`
						},
					},
				);
				this.totalIncomeNumber = data.data;
			} catch (error) {
				if (axios.isAxiosError(error)) {
					this.error = error.message;
				} else {
					this.error = "An unexpected error occurred";
				}
			} finally {
				this.totalIncomeLoading = false;
			}
		},

		async getOrderByCountry() {
			this.ordersByCountryLoading = true;
			try {
				const { data, status } = await axios.get(
					`${API_BASE_URL}/dashboard/income-amount`,
					{
						headers: {
							"Content-Type": "application/json",
							"Authorization": `Bearer ${useUserStore().token}`
						},
					},
				);
				this.countryOrders = data.data;
			} catch (error) {
				if (axios.isAxiosError(error)) {
					this.error = error.message;
				} else {
					this.error = "An unexpected error occurred";
				}
			} finally {
				this.ordersByCountryLoading = false;
			}
		},

		async getLastestOrder() {
			this.ordersByCountryLoading = true;
			try {
				const { data, status } = await axios.get(
					`${API_BASE_URL}/dashboard/income-amount`,
					{
						headers: {
							"Content-Type": "application/json",
							"Authorization": `Bearer ${useUserStore().token}`
						},
					},
				);
				this.orders = data.data;
			} catch (error) {
				if (axios.isAxiosError(error)) {
					this.error = error.message;
				} else {
					this.error = "An unexpected error occurred";
				}
			} finally {
				this.ordersByCountryLoading = false;
			}
		},

		async getLatestCustomer() {
			this.customersCountLoading = true;
			try {
				const { data, status } = await axios.get(
					`${API_BASE_URL}/dashboard/latest-customers`,
					{
						headers: {
							"Content-Type": "application/json",
							"Authorization": `Bearer ${useUserStore().token}`
						},
					},
				);
				this.customers = data.data;
			} catch (error) {
				if (axios.isAxiosError(error)) {
					this.error = error.message;
				} else {
					this.error = "An unexpected error occurred";
				}
			} finally {
				this.customersCountLoading = false;
			}
		},
	}
});

if (import.meta.hot) {
	import.meta.hot?.accept(acceptHMRUpdate(useDashboardStore, import.meta.hot))
}