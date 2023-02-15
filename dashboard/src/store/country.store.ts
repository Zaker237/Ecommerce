// @ts-check
import { defineStore, acceptHMRUpdate } from "pinia";
import {
	GetCountriesResponse,
	RootCountryState,
} from "../types/country";
import axios from "axios";
import { useUserStore } from "./user.store";
const API_BASE_URL = import.meta.env.VITE_API_BASE_URL;

export const useCountryStore = defineStore({
	id: "countries",
	state: () => ({
		countries: [],
		links: null,
  	meta: null,
		loading: false,
		error: null
	} as RootCountryState),

	getters: {
		items: (state) => state.countries
	},

	actions: {
		async getItems() {
			this.loading = true;
			try {
				const { data, status } = await axios.get<GetCountriesResponse>(
					`${API_BASE_URL}/countries`,
					{
						headers: {
							"Content-Type": "application/json",
							"Authorization": `Bearer ${useUserStore().token}`
						},
					},
				);
				this.countries = data.data;
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
		}
	},
})

if (import.meta.hot) {
	import.meta.hot?.accept(acceptHMRUpdate(useCountryStore, import.meta.hot))
}