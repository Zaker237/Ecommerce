import { createRouter, createWebHistory } from "vue-router";
import AppLayout from "../components/AppLayout.vue";
import Login from "../views/Login.vue";
import Dashboard from "../views/Dashboard.vue";
import Products from "../views/products/Products.vue";
import Users from "../views/users/Users.vue";
import Customers from "../views/customers/Customers.vue";
import CustomerView from "../views/customers/CustomerView.vue";
import Orders from "../views/orders/Orders.vue";
import OrderView from "../views/orders/OrderView.vue";
import RequestPassword from "../views/RequestPassword.vue";
import ResetPassword from "../views/ResetPassword.vue";
import NotFound from "../views/NotFound.vue";
import { useUserStore } from "../store";
import Report from "../views/reports/Report.vue";
import OrdersReport from "../views/reports/OrdersReport.vue";
import CustomersReport from "../views/reports/CustomersReport.vue";

const router = createRouter({
  history: createWebHistory(),
  routes:[
    {
      path: "/",
      redirect: "/app"
    },
    {
      path: "/app",
      name: "app",
      redirect: "/app/dashboard",
      component: AppLayout,
      meta: {
        requiresAuth: true
      },
      children: [
        {
          path: "dashboard",
          name: "app.dashboard",
          component: Dashboard
        },
        {
          path: "products",
          name: "app.products",
          component: Products
        },
        {
          path: "users",
          name: "app.users",
          component: Users
        },
        {
          path: "customers",
          name: "app.customers",
          component: Customers
        },
        {
          path: "customers/:id",
          name: "app.customers.view",
          component: CustomerView
        },
        {
          path: "orders",
          name: "app.orders",
          component: Orders
        },
        {
          path: "orders/:id",
          name: "app.orders.view",
          component: OrderView
        },
        {
          path: "/report",
          name: "reports",
          component: Report,
          meta: {
            requiresAuth: true
          },
          children: [
            {
              path: "orders/:date?",
              name: "reports.orders",
              component: OrdersReport
            },
            {
              path: "customers/:date?",
              name: "reports.customers",
              component: CustomersReport
            }
          ]
        },
      ]
    },
    {
      path: "/login",
      name: "login",
      component: Login,
      meta: {
        requiresGuest: true
      }
    },
    {
      path: "/request-password",
      name: "requestPassword",
      component: RequestPassword,
      meta: {
        requiresGuest: true
      }
    },
    {
      path: "/reset-password/:token",
      name: "resetPassword",
      component: ResetPassword,
      meta: {
        requiresGuest: true
      }
    },
    {
      path: "/:pathMatch(.*)",
      name: "notfound",
      component: NotFound,
    }
  ]
})

router.beforeEach((to, from, next) => {
  if (to.meta.requiresAuth && !useUserStore().token) {
    next({name: "login"})
  } else if (to.meta.requiresGuest && useUserStore().token) {
    next({name: "app.dashboard"})
  } else {
    next();
  }

})

export default router;