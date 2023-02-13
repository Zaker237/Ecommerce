// @ts-check
import { defineStore, acceptHMRUpdate } from "pinia";
import {
	ICustomer,
	GetCustomersResponse,
	RootCustomerState,
	GetCustomersParams
} from "../types/customer";
import axios from "axios";
import { useUserStore } from "./user.store";
import { CUSTOMERS_PER_PAGE } from "../constants";
const API_BASE_URL = import.meta.env.VITE_API_BASE_URL;

export const useCustomerStore = defineStore({
	id: "customers",
	state: () => ({
		customers: [],
		links: [],
  	meta: [],
		loading: false,
		error: null
	} as RootCustomerState),

	getters: {
		items: (state) => state.customers
	},

	actions: {
		async getItems(configs: GetCustomersParams) {
			this.loading = true;
			const url = configs.url? configs.url : `${API_BASE_URL}/customers`;
      const params = {per_page: CUSTOMERS_PER_PAGE, ...configs};
			try {
				const { data, status } = await axios.get<GetCustomersResponse>(
					url,
					{
						params: { ...params },
						headers: {
							"Content-Type": "application/json",
							"Authorization": `Bearer ${useUserStore().token}`
						},
					},
				);
				this.customers = data.data;
				this.links = data.links;
				this.meta = data.meta;
			} catch (error) {
				if (axios.isAxiosError(error)) {
					this.error = error.message;
				} else {
					this.error = "An unexpected error occurred";
				}
			} finally {
				this.loading = false;
			}
		},

		async getItem(id: number) {
			this.loading = true;
			try {
				const { data, status } = await axios.get<ICustomer>(
					`${API_BASE_URL}/customers/${id}`,
					{
						headers: {
							"Content-Type": "application/json",
							"Authorization": `Bearer ${useUserStore().token}`
						},
					},
				);

				return data;
			} catch (error) {
				if (axios.isAxiosError(error)) {
					this.error = error.message;
				} else {
					this.error = "An unexpected error occurred";
				}
				return {}
			} finally {
				this.loading = false;
			}
		},

		async addItem(customer: ICustomer) {
			this.loading = true;
			try {
				const { data, status } = await axios.post<ICustomer>(
					`${API_BASE_URL}/customers`,
					{...customer},
					{
						headers: {
							"Content-Type": "application/json",
							"Authorization": `Bearer ${useUserStore().token}`
						},

					},
				);
				if (status === 200) {
					this.customers.push(data);
				}
			} catch (error) {
				if (axios.isAxiosError(error)) {
					this.error = error.message;
				} else {
					this.error = "An unexpected error occurred";
				}
			} finally {
				this.loading = false;
			}
		},

		async updateItem(newCustomer: ICustomer) {
			console.log(newCustomer);
			this.loading = true;
			try {
				const { data, status } = await axios.put<ICustomer>(
					`${API_BASE_URL}/customers/${newCustomer.id}`,
					{ ...newCustomer },
					{
						headers: {
							"Content-Type": "application/json",
							"Authorization": `Bearer ${useUserStore().token}`
						},
					},
				);
				if (status === 200) {
					const idx = this.customers.findIndex(
						elem => elem.id === newCustomer.id
					)
					this.customers[idx] = { ...data };
				}
			} catch (error) {
				if (axios.isAxiosError(error)) {
					this.error = error.message;
				} else {
					this.error = "An unexpected error occurred";
				}
			} finally {
				this.loading = false;
			}
		},

		async removeItem(id: number ) {
			this.loading = true;
			try {
				const { data, status } = await axios.delete<ICustomer>(
					`${API_BASE_URL}/customers/${id}`,
					{
						headers: {
							"Content-Type": "application/json",
							"Authorization": `Bearer ${useUserStore().token}`
						},
					},
				);
				if (status === 200) {
					this.customers = this.customers.filter(
						elem => elem.id !== id
					);
				}
			} catch (error) {
				if (axios.isAxiosError(error)) {
					this.error = error.message;
				} else {
					this.error = "An unexpected error occurred";
				}
			} finally {
				this.loading = false;
			}
		},
	},
})

if (import.meta.hot) {
	import.meta.hot?.accept(acceptHMRUpdate(useCustomerStore, import.meta.hot))
}