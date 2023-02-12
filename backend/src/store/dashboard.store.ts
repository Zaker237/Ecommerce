import { defineStore, acceptHMRUpdate } from "pinia";
import {
	RootDashboardState,
} from "../types/dashboard";
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
		latestCustomersLoading: false,
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
		ordersByCountry: (state) => state.countryOrders,
		loadingCustomersCount: (state) => state.customersCountLoading,
		loadingProductsCount: (state) => state.productsCountLoading,
		loadingPaidOrders: (state) => state.paidOrdersLoading,
		LoadingTotalIncome: (state) => state.totalIncomeLoading,
		LoadingLatestCustomers: (state) => state.latestCustomersLoading,
		LoadingLatestOrders: (state) => state.latestOrdersLoading,
		LoadingOrdersByCountry: (state) => state.ordersByCountryLoading,
	},
	actions: {
		async getCustomerCount(period: String) {
			this.customersCountLoading = true;
			const params = {d: period};
			try {
				const { data, status } = await axios.get(
					`${API_BASE_URL}/dashboard/customers-count`,
					{
						params: { ...params },
						headers: {
							"Content-Type": "application/json",
							"Authorization": `Bearer ${useUserStore().token}`
						},
					},
				);
				this.customerNumber = data;
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

		async getProductCount(period: String) {
			this.productsCountLoading = true;
			const params = {d: period};
			try {
				const { data, status } = await axios.get(
					`${API_BASE_URL}/dashboard/products-count`,
					{
						params: { ...params },
						headers: {
							"Content-Type": "application/json",
							"Authorization": `Bearer ${useUserStore().token}`
						},
					},
				);
				this.productNumber = data;
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

		async getOrderCount(period: String) {
			this.ordersByCountryLoading = true;
			const params = {d: period};
			try {
				const { data, status } = await axios.get(
					`${API_BASE_URL}/dashboard/orders-count`,
					{
						params: { ...params },
						headers: {
							"Content-Type": "application/json",
							"Authorization": `Bearer ${useUserStore().token}`
						},
					},
				);
				this.paidOrderNumber = data;
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

		async getTotalIncome(period: String) {
			this.totalIncomeLoading = true;
			const params = {d: period};
			try {
				const { data, status } = await axios.get(
					`${API_BASE_URL}/dashboard/income-amount`,
					{
						params: { ...params },
						headers: {
							"Content-Type": "application/json",
							"Authorization": `Bearer ${useUserStore().token}`
						},
					},
				);
				this.totalIncomeNumber = data;
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

		async getOrderByCountry(period: String) {
			this.ordersByCountryLoading = true;
			const params = {d: period};
			try {
				const { data, status } = await axios.get(
					`${API_BASE_URL}/dashboard/orders-by-country`,
					{
						params: { ...params },
						headers: {
							"Content-Type": "application/json",
							"Authorization": `Bearer ${useUserStore().token}`
						},
					},
				);
				this.countryOrders = data;
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

		async getLastestOrder(period: String) {
			this.ordersByCountryLoading = true;
			const params = {d: period};
			try {
				const { data, status } = await axios.get(
					`${API_BASE_URL}/dashboard/latest-orders`,
					{
						params: { ...params },
						headers: {
							"Content-Type": "application/json",
							"Authorization": `Bearer ${useUserStore().token}`
						},
					},
				);
				this.orders = data;
				console.log(data);
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

		async getLatestCustomer(period: String) {
			this.latestCustomersLoading = true;
			const params = {d: period};
			try {
				const { data, status } = await axios.get(
					`${API_BASE_URL}/dashboard/latest-customers`,
					{
						params: { ...params },
						headers: {
							"Content-Type": "application/json",
							"Authorization": `Bearer ${useUserStore().token}`
						},
					},
				);
				this.customers = data;
			} catch (error) {
				if (axios.isAxiosError(error)) {
					this.error = error.message;
				} else {
					this.error = "An unexpected error occurred";
				}
			} finally {
				this.latestCustomersLoading = false;
			}
		},
	}
});

if (import.meta.hot) {
	import.meta.hot?.accept(acceptHMRUpdate(useDashboardStore, import.meta.hot))
}