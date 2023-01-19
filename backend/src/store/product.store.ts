// @ts-check
import { defineStore, acceptHMRUpdate } from "pinia";
import { IProduct, GetProductResponse, RootProductState } from "../types/product";
import axios from "axios";
import { useUserStore } from "./user.store";
const BASE_ENDPOINT = import.meta.env.VITE_API_BASE_URL;

export const useProductStore = defineStore({
	id: "products",
	state: () => ({
		products: [],
		loading: false,
		error: null
	} as RootProductState),

	getters: {
		items: (state) => state.products,
	},

	actions: {
		async getItems() {
			this.loading = true;
			try {
				const { data, status } = await axios.get<GetProductResponse>(
					BASE_ENDPOINT + "/products",
					{
						headers: {
							"Content-Type": "application/json"
						},
					},
				);
				this.products = data.data;
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
				const { data, status } = await axios.get<GetProductResponse>(
					BASE_ENDPOINT + `/products/${id}`,
					{
						headers: {
							"Content-Type": "application/json"
						},
					},
				);
				this.products = data.data;
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

		async addItem(product: IProduct) {
			this.loading = true;
			try {
				const { data, status } = await axios.post<IProduct>(
					BASE_ENDPOINT + "/products",
					{...product},
					{
						headers: {
							"Content-Type": "application/json",
							"Authorization": `Bearer ${useUserStore().token}`
						},

					},
				);
				if (status === 200) {
					this.products.push(data);
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

		async updateItem(newProduct: IProduct) {
			this.loading = true;
			try {
				const { data, status } = await axios.put<IProduct>(
					BASE_ENDPOINT + `products/${newProduct.id}`,
					{ ...newProduct },
					{
						headers: {
							"Content-Type": "application/json",
							"Authorization": `Bearer ${useUserStore().token}`
						},
					},
				);
				if (status === 200) {
					const idx = this.products.findIndex(
						elem => elem.id === newProduct.id
					)
					this.products[idx] = { ...data };
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

		async removeItem(id: number) {
			this.loading = true;
			try {
				const { data, status } = await axios.delete<IProduct>(
					BASE_ENDPOINT + `products/${id}`,
					{
						headers: {
							"Content-Type": "application/json",
							"Authorization": `Bearer ${useUserStore().token}`
						},
					},
				);
				if (status === 200) {
					this.products = this.products.filter(
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
		}
	},
})

if (import.meta.hot) {
	import.meta.hot?.accept(acceptHMRUpdate(useProductStore, import.meta.hot))
}