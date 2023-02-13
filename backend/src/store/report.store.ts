import { defineStore, acceptHMRUpdate } from "pinia";
import axios from "axios";
import { useUserStore } from "./user.store";
const API_BASE_URL = import.meta.env.VITE_API_BASE_URL;

export const useReportStore = defineStore({
	id: "reports",
	state: () => {
		return {
			optionsDate: [
				{key: '1d', text: 'Last Day'},
				{key: '1k', text: 'Last Week'},
				{key: '2k', text: 'Last 2 Weeks'},
				{key: '1m', text: 'Last Month'},
				{key: '3m', text: 'Last 3 Months'},
				{key: '6m', text: 'Last 6 Months'},
				{key: 'all', text: 'All Time'},
			],
			loading: false,
			error: ""
		}
	},

	getters : {
		dateOptions: (state) => state.optionsDate,
	},

	actions: {
		async getOrdersReport(period: String) {
			this.loading = true;
			const params = {d: period};
			try {
				const { data, status } = await axios.get(
					`${API_BASE_URL}/report/orders`,
					{
						params: { ...params },
						headers: {
							"Content-Type": "application/json",
							"Authorization": `Bearer ${useUserStore().token}`
						},
					},
				);
				if (status === 200) {
					return data;
				}else{
					return [];
				}
			} catch (error) {
				if (axios.isAxiosError(error)) {
					this.error = error.message;
				} else {
					this.error = "An unexpected error occurred";
				}
				return [];
			} finally {
				this.loading = false;
			}
		},

		async getCustomersReport(period: String) {
			this.loading = true;
			const params = {d: period};
			try {
				const { data, status } = await axios.get(
					`${API_BASE_URL}/report/customers`,
					{
						params: { ...params },
						headers: {
							"Content-Type": "application/json",
							"Authorization": `Bearer ${useUserStore().token}`
						},
					},
				);
				if (status === 200) {
					return data;
				}else{
					return [];
				}
			} catch (error) {
				if (axios.isAxiosError(error)) {
					this.error = error.message;
				} else {
					this.error = "An unexpected error occurred";
				}
				return [];
			} finally {
				this.loading = false;
			}
		},
	}
})

if (import.meta.hot) {
	import.meta.hot?.accept(acceptHMRUpdate(useReportStore, import.meta.hot))
}