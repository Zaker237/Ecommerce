// @ts-check
import { defineStore, acceptHMRUpdate } from "pinia";
import { IUser, IUserLogin, ILoginResponse, RootUserState } from "../types/user";
import axios from "axios";
const API_BASE_URL = import.meta.env.VITE_API_BASE_URL;

export const useUserStore = defineStore({
  id: 'users',
  state: () => ({
    sIsAdmin: true,
    sUser: {},
    sToken: sessionStorage.getItem('TOKEN'),
    loading: false,
		error: null
  } as RootUserState),

  getters: {
    user: (state) => state.sUser,
    token: (state) => state.sToken,
    isAdmin: (state) => state.sIsAdmin
  },

  actions: {
    async login(user: IUserLogin) {
      this.loading = true;
			try {
				const { data, status } = await axios.post<ILoginResponse>(
          `${API_BASE_URL}/login`,
          {...user},
					{
						headers: {
							"Content-Type": "application/json"
						},
					},
        );
        console.log(data);
        this.sToken = data.token;
        this.sUser = data.user;
        sessionStorage.setItem("TOKEN", data.token);
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

    async logout() {
      this.loading = true;
			try {
				const { data, status } = await axios.post(
          `${API_BASE_URL}/logout`,
					{},
					{
						headers: {
							"Content-Type": "application/json",
							"Authorization": `Bearer ${this.token}`
						},
					},
				);
        this.sToken = "";
        this.sUser = {};
        sessionStorage.removeItem("TOKEN");
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

    async getCurrentUser() {
      this.loading = true;
			try {
				const { data, status } = await axios.get(
          `${API_BASE_URL}/user`,
					{
						headers: {
							"Content-Type": "application/json",
							"Authorization": `Bearer ${useUserStore().token}`
						},
					},
				);
        this.sUser = data.user;
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
  }
})

if (import.meta.hot) {
  import.meta.hot?.accept(acceptHMRUpdate(useUserStore, import.meta.hot))
}