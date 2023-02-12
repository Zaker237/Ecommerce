import { createApp } from "vue";
import { createPinia } from "pinia";
import "./style.css";
import currencyUSD from "./filters/curency";
import App from "./App.vue";
import router from "./router";

const store = createPinia();
const app = createApp(App);

app.use(store);
app.use(router);
app.mount("#app");

app.config.globalProperties.$filters = {
  currencyUSD
}
