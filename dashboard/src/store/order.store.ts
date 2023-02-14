// @ts-check
import { defineStore, acceptHMRUpdate } from "pinia";
import { IOrder, GetOrdersResponse, RootOrderState, GetOrdersParams } from "../types/order";
import axios from "axios";
import { useUserStore } from "./user.store";
import { PRODUCTS_PER_PAGE } from "../constants";
const API_BASE_URL = import.meta.env.VITE_API_BASE_URL;

export const useOrderStore = defineStore({
	id: "orders",
	state: () => ({
		orders: [],
		statuse: [],
		links: null,
  	meta: null,
		loading: false,
		error: null
	} as RootOrderState),

	getters: {
		items: (state) => state.orders,
	},

	actions: {
		async getItems(configs: GetOrdersParams) {
			this.loading = true;
			const url = configs.url? configs.url : `${API_BASE_URL}/orders`;
      const params = {per_page: PRODUCTS_PER_PAGE, ...configs};
			try {
				const { data, status } = await axios.get<GetOrdersResponse>(
					url,
					{
						params: { ...params },
						headers: {
							"Content-Type": "application/json",
							"Authorization": `Bearer ${useUserStore().token}`
						},
					},
				);
				this.orders = data.data;
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

		async getItem(id: string): Promise<IOrder | null> {
			this.loading = true;
			try {
				const { data, status } = await axios.get<IOrder>(
					`${API_BASE_URL}/orders/${id}`,
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
				return null;
			} finally {
				this.loading = false;
			}
		},

		async addItem(order: IOrder) {
			this.loading = true;
			try {
				const { data, status } = await axios.post<IOrder>(
					`${API_BASE_URL}/orders`,
					{...order},
					{
						headers: {
							"Content-Type": "application/json",
							"Authorization": `Bearer ${useUserStore().token}`
						},

					},
				);
				if (status === 200) {
					this.orders.push(data);
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

		async updateItem(newOrder: IOrder) {
			this.loading = true;
			try {
				const { data, status } = await axios.put<IOrder>(
					`${API_BASE_URL}/orders/${newOrder.id}`,
					{ ...newOrder },
					{
						headers: {
							"Content-Type": "application/json",
							"Authorization": `Bearer ${useUserStore().token}`
						},
					},
				);
				if (status === 200) {
					const idx = this.orders.findIndex(
						elem => elem.id === newOrder.id
					)
					this.orders[idx] = { ...data };
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
				const { data, status } = await axios.delete<IOrder>(
					`${API_BASE_URL}/orders/${id}`,
					{
						headers: {
							"Content-Type": "application/json",
							"Authorization": `Bearer ${useUserStore().token}`
						},
					},
				);
				if (status === 200) {
					this.orders = this.orders.filter(
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

		async getOrderStatuse() {
			this.loading = true;
			try {
				const { data, status } = await axios.get<string[]>(
					`${API_BASE_URL}/orders/statuses`,
					{
						headers: {
							"Content-Type": "application/json",
							"Authorization": `Bearer ${useUserStore().token}`
						},
					},
				);
				if (status === 200) {
					this.statuse = data;
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

		async updateStatus(id: number, value: string) {
			this.loading = true;
			try {
				const { data, status } = await axios.post(
					`${API_BASE_URL}/orders/change-status/${id}/${value}`,
					{},
					{
						headers: {
							"Content-Type": "application/json",
							"Authorization": `Bearer ${useUserStore().token}`
						},
					},
				);
				if (status === 200) {
					return value;
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
	import.meta.hot?.accept(acceptHMRUpdate(useOrderStore, import.meta.hot))
}