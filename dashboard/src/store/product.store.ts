// @ts-check
import { defineStore, acceptHMRUpdate } from "pinia";
import { IProduct, GetProductsResponse, RootProductState, GetProductsParams } from "../types/product";
import axios from "axios";
import { useUserStore } from "./user.store";
import { PRODUCTS_PER_PAGE } from "../constants";
const API_BASE_URL = import.meta.env.VITE_API_BASE_URL;

export const useProductStore = defineStore({
	id: "products",
	state: () => ({
		products: [],
		links: null,
  	meta: null,
		loading: false,
		error: null
	} as RootProductState),

	getters: {
		items: (state) => state.products,
	},

	actions: {
		async getItems(configs: GetProductsParams) {
			this.loading = true;
			const url = configs.url? configs.url : `${API_BASE_URL}/products`;
      const params = {per_page: PRODUCTS_PER_PAGE, ...configs};
			try {
				const { data, status } = await axios.get<GetProductsResponse>(
					url,
					{
						params: { ...params },
						headers: {
							"Content-Type": "application/json",
							"Authorization": `Bearer ${useUserStore().token}`
						},
					},
				);
				this.products = data.data;
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

		async getItem(id: string): Promise<IProduct | null> {
			this.loading = true;
			try {
				const { data, status } = await axios.get<IProduct>(
					`${API_BASE_URL}/products/${id}`,
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

		async addItem(product: IProduct) {
			this.loading = true;
			const form = new FormData();
			form.append('id', String(product.id));
			form.append('title', product.title);
			form.append('image', product.image);
			form.append('description', product.description || "");
			form.append('price', String(product.price));
			form.append('published', product.published ? "1": "0");

			try {
				const { data, status } = await axios.post<IProduct>(
					`${API_BASE_URL}/products`,
					form,
					{
						headers: {
							"Content-Type": "multipart/form-data",
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
			const prod = new FormData();
			prod.append('id', String(newProduct.id));
			prod.append('title', newProduct.title);
			prod.append('image', newProduct.image);
			prod.append('description', newProduct.description || "");
			prod.append('price', String(newProduct.price));
			prod.append('published', newProduct.published ? "1" : "0");

			try {
				const { data, status } = await axios.put<IProduct>(
					`${API_BASE_URL}/products/${newProduct.id}`,
					prod,
					{
						headers: {
							"Content-Type": "multipart/form-data",
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

		async removeItem(id: number ) {
			this.loading = true;
			try {
				const { data, status } = await axios.delete<IProduct>(
					`${API_BASE_URL}/products/${id}`,
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