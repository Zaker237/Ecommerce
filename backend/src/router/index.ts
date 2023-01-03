import { createRouter, createWebHistory } from "vue-router";
import Login from "./../views/Login.vue";
import Dashboard from "./../views/Dashboard.vue";
import RequestPassword from "./../views/RequestPassword.vue";
import ResetPassword from "./../views/ResetPassword.vue";

const router = createRouter({
  history: createWebHistory(),
  routes: [
		{
      path: "/dashboard",
      name: "dashboard",
      component: Dashboard
    },
    {
      path: "/login",
      name: "login",
      component: Login
    },
		{
      path: "/request-password",
      name: "requestpassword",
      component: RequestPassword
    },
    {
      path: "/reset-password",
      name: "resetpassword",
      component: ResetPassword
    },
	]
})

export default router;