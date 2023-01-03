// @ts-check
import { defineStore, acceptHMRUpdate } from "pinia";

export const useUserStore = defineStore({
  id: 'user',
  state: () => ({
    name: 'Eduardo',
    isAdmin: true,
    theUser: {
      token: null
    }
  }),

  getters: {
    user: (state) => state.theUser
  },

  actions: {
    logout() {
      //logout
    },

    /**
     * Attempt to login a user
     * @param {string} user
     * @param {string} password
     */
    async login(user: string, password: string) {
        // login
    },
  },
})

if (import.meta.hot) {
  import.meta.hot?.accept(acceptHMRUpdate(useUserStore, import.meta.hot))
}