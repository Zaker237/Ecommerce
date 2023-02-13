// @ts-check
import { defineStore, acceptHMRUpdate } from "pinia";

import { RootToastState } from "../types/toast";

export const useToastStore = defineStore({
	id: "toast",
	state: () => ({
		stateShow: false,
    stateMessage: '',
    stateDelay: 5000
	} as RootToastState),

	getters: {
		show: (state) => state.stateShow,
		message: (state) => state.stateMessage,
		delay: (state) => state.stateDelay
	},

	actions: {
		hideToast(){
			this.stateShow = false;
		},

		setMessage(value: string){
			this.stateMessage = value;
			this.stateShow = true;
		}
	},
})

if (import.meta.hot) {
	import.meta.hot?.accept(acceptHMRUpdate(useToastStore, import.meta.hot))
}