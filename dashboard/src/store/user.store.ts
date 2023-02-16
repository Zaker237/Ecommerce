// @ts-check
import { defineStore, acceptHMRUpdate } from "pinia";
import {
	IUser,
	IUserLogin,
	ILoginResponse,
	RootUserState,
	GetUsersParams,
	GetUserResponse,
	GetUsersResponse
} from "../types/user";
import axios from "axios";
import { USERS_PER_PAGE } from "../constants";
const API_BASE_URL = import.meta.env.VITE_API_BASE_URL;

export const useUserStore = defineStore({
  id: 'users',
  state: () => ({
		users: [],
    sIsAdmin: true,
    currentUser: {id:0, name: "", email: "", created_at: ""},
		sToken: sessionStorage.getItem('TOKEN'),
		links: null,
  	meta: null,
    loading: false,
		error: null
  } as RootUserState),

  getters: {
		items: (state) => state.users,
    user: (state) => state.currentUser,
    token: (state) => state.sToken,
    isAdmin: (state) => state.sIsAdmin,
		isloading: (state) => state.loading
  },

  actions: {
		async getItems(configs: GetUsersParams) {
			this.loading = true;
			const url = configs.url? configs.url : `${API_BASE_URL}/users`;
      const params = {per_page: USERS_PER_PAGE, ...configs};
			try {
				const { data, status } = await axios.get<GetUsersResponse>(
					url,
					{
						params: { ...params },
						headers: {
							"Content-Type": "application/json",
							"Authorization": `Bearer ${this.token}`
						},
					},
				);
				this.users = data.data;
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
				const { data, status } = await axios.get<IUser>(
					`${API_BASE_URL}/users/${id}`,
					{
						headers: {
							"Content-Type": "application/json",
							"Authorization": `Bearer ${this.token}`
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

		async addItem(user: IUser) {
			this.loading = true;
			try {
				const { data, status } = await axios.post<IUser>(
					`${API_BASE_URL}/users`,
					{...user},
					{
						headers: {
							"Content-Type": "application/json",
							"Authorization": `Bearer ${this.token}`
						},

					},
				);
				if (status === 200) {
					this.users.push(data);
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

		async updateItem(newUser: IUser) {
			this.loading = true;
			try {
				const { data, status } = await axios.put<IUser>(
					`${API_BASE_URL}/users/${newUser.id}`,
					{ ...newUser },
					{
						headers: {
							"Content-Type": "application/json",
							"Authorization": `Bearer ${this.token}`
						},
					},
				);
				if (status === 200) {
					const idx = this.users.findIndex(
						elem => elem.id === newUser.id
					)
					this.users[idx] = { ...data };
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
				const { data, status } = await axios.delete<IUser>(
					`${API_BASE_URL}/users/${id}`,
					{
						headers: {
							"Content-Type": "application/json",
							"Authorization": `Bearer ${this.token}`
						},
					},
				);
				if (status === 200) {
					this.users = this.users.filter(
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

    async login(user: IUserLogin): Promise<boolean> {
      this.loading = true;
			let result: boolean = false;
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
        this.sToken = data.token;
        this.currentUser = data.user;
        sessionStorage.setItem("TOKEN", data.token);
				result = true;
			} catch (error) {
				if (axios.isAxiosError(error)) {
					this.error = error.message;
				} else {
					this.error = "An unexpected error occurred";
				}
				result = false;
			} finally {
				this.loading = false;
			}
			return result;
    },

    async logout(): Promise<boolean> {
      this.loading = true;
			let result: boolean = false;
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
        this.currentUser = {id:0, name: "", email: "", created_at: ""};
        sessionStorage.removeItem("TOKEN");
				result = true;
			} catch (error) {
				if (axios.isAxiosError(error)) {
					this.error = error.message;
				} else {
					this.error = "An unexpected error occurred";
				}
				result = false;
			} finally {
				this.loading = false;
			}
			return result;
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
        this.currentUser = data.user;
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