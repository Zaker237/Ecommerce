<script setup lang="ts">
import {UserIcon} from '@heroicons/vue/24/outline'
import DoughnutChart from '../components/core/charts/Doughnut.vue'
import {onMounted, ref, Ref, computed} from "vue";
import Spinner from "../components/core/Spinner.vue";
// import { IDateOptions } from "../types/dashboard";
// import { ICustomer } from "../types/customer";
import currencyUSD from "../filters/curency";
import { IChartData } from "../types/dashboard";
import CustomInput from "../components/core/CustomInput.vue";
import { useDashboardStore } from "../store/dashboard.store";
import { useReportStore } from "../store/report.store";

const dashboardStore = useDashboardStore();
const reportStore = useReportStore();

const dateOptions = computed(() => reportStore.dateOptions);

const chosenDate = ref('all');

const customersCount = computed(() => dashboardStore.customerCount);
const productsCount = computed(() => dashboardStore.productCount);
const paidOrders = computed(() => dashboardStore.paidOrderCount);
const totalIncome = computed(() => dashboardStore.totalIncomeCount);
const ordersByCountry = computed(() => dashboardStore.ordersByCountry);
const latestCustomers = computed(() => dashboardStore.latestCustomers);
const latestOrders = computed(() => dashboardStore.latestOrders);

const customersCountLoading = computed(() => dashboardStore.customersCountLoading);
const productsCountLoading = computed(() => dashboardStore.productsCountLoading);
const paidOrdersLoading = computed(() => dashboardStore.paidOrdersLoading);
const totalIncomeLoading = computed(() => dashboardStore.totalIncomeLoading);
const ordersByCountryLoading = computed(() => dashboardStore.ordersByCountryLoading);
const latestCustomersLoading = computed(() => dashboardStore.latestCustomersLoading);
const latestOrdersLoading = computed(() => dashboardStore.latestOrdersLoading);

const chartDataValues = ref({});

const updateDashboard = async () => {
	await dashboardStore.getCustomerCount(chosenDate.value);
	await dashboardStore.getProductCount(chosenDate.value);
	await dashboardStore.getOrderCount(chosenDate.value);
	await dashboardStore.getTotalIncome(chosenDate.value);
	await dashboardStore.getOrderByCountry(chosenDate.value);
	await dashboardStore.getLatestCustomer(chosenDate.value);
	await dashboardStore.getLastestOrder(chosenDate.value);
	// build chart data
	let chartData: IChartData = {
    labels: [],
    datasets: [{
      backgroundColor: ['#41B883', '#E46651', '#00D8FF', '#DD1B16'],
      data: []
    }]
  }
	ordersByCountry.value.forEach(elem => {
		chartData.labels.push(elem.name);
		chartData.datasets[0].data.push(elem.count);
	});
	chartDataValues.value = chartData;
}

const onDatePickerChange = async () => {
  await updateDashboard();
}

onMounted(async () => {
	await updateDashboard();
});
</script>

<template>
	<div class="mb-2 flex items-center justify-between">
    <h1 class="text-3xl font-semibold">Dashboard</h1>
    <div class="flex items-center">
      <label class="mr-2">Change Date Period</label>
      <CustomInput type="select" v-model="chosenDate" @change="onDatePickerChange" :select-options="dateOptions"/>
    </div>
  </div>
  <div class="grid grid-cols-1 md:grid-cols-4 gap-3 mb-4">
    <!--    Active Customers-->
    <div class="animate-fade-in-down bg-white py-6 px-5 rounded-lg shadow flex flex-col items-center justify-center">
      <label class="text-lg font-semibold block mb-2">Active Customers</label>
      <template v-if="!customersCountLoading">
        <span class="text-3xl font-semibold">{{ customersCount }}</span>
      </template>
      <Spinner v-else text="" class=""/>
    </div>
    <!--/    Active Customers-->
    <!--    Active Products -->
    <div class="animate-fade-in-down bg-white py-6 px-5 rounded-lg shadow flex flex-col items-center justify-center"
         style="animation-delay: 0.1s">
      <label class="text-lg font-semibold block mb-2">Active Products</label>
      <template v-if="!productsCountLoading">
        <span class="text-3xl font-semibold">{{ productsCount }}</span>
      </template>
      <Spinner v-else text="" class=""/>
    </div>
    <!--/    Active Products -->
    <!--    Paid Orders -->
    <div class="animate-fade-in-down bg-white py-6 px-5 rounded-lg shadow flex flex-col items-center justify-center"
         style="animation-delay: 0.2s">
      <label class="text-lg font-semibold block mb-2">Paid Orders</label>
      <template v-if="!paidOrdersLoading">
        <span class="text-3xl font-semibold">{{ paidOrders }}</span>
      </template>
      <Spinner v-else text="" class=""/>
    </div>
    <!--/    Paid Orders -->
    <!--    Total Income -->
    <div class="animate-fade-in-down bg-white py-6 px-5 rounded-lg shadow flex flex-col items-center"
         style="animation-delay: 0.3s">
      <label class="text-lg font-semibold block mb-2">Total Income</label>
      <template v-if="!totalIncomeLoading">
        <span class="text-3xl font-semibold">{{ totalIncome ? currencyUSD(totalIncome) : 0 }}</span>
      </template>
      <Spinner v-else text="" class=""/>
    </div>
    <!--/    Total Income -->
  </div>

  <div class="grid grid-rows-1 md:grid-rows-2 md:grid-flow-col grid-cols-1 md:grid-cols-3 gap-3">
    <div class="col-span-1 md:col-span-2 row-span-1 md:row-span-2 bg-white py-6 px-5 rounded-lg shadow">
      <label class="text-lg font-semibold block mb-2">Latest Orders</label>
      <template v-if="!latestOrdersLoading">
        <div
					v-for="o in latestOrders"
					:key="o.id"
					class="py-2 px-3 hover:bg-gray-50"
				>
          <p>
            <router-link
							:to="{name: 'app.orders.view', params: {id: o.id}}"
							class="text-indigo-700 font-semibold"
						>
              Order #{{ o.id }}
            </router-link>
            created {{ o.created_at }}. {{ o.items }} items
          </p>
          <p class="flex justify-between">
            <span>{{ o.first_name }} {{ o.last_name }}</span>
            <span>{{ currencyUSD(o.total_price) }}</span>
          </p>
        </div>
      </template>
      <Spinner v-else text="" class=""/>
    </div>
    <div class="bg-white py-6 px-5 rounded-lg shadow flex flex-col items-center justify-center">
      <label class="text-lg font-semibold block mb-2">Orders by Country</label>
      <template v-if="!ordersByCountryLoading">
        <DoughnutChart :width="140" :height="200" :data="chartDataValues"/>
      </template>
      <Spinner v-else text="" class=""/>
    </div>
    <div class="bg-white py-6 px-5 rounded-lg shadow">
      <label class="text-lg font-semibold block mb-2">Latest Customers</label>
      <template v-if="!latestCustomersLoading">
        <router-link
					v-if="latestCustomers.length > 0"
					v-for="c in latestCustomers"
					:key="c.id"
					:to="{name: 'app.customers.view', params: {id: c.id}}"
          class="mb-3 flex"
				>
          <div class="w-12 h-12 bg-gray-200 flex items-center justify-center rounded-full mr-2">
            <UserIcon class="w-5"/>
          </div>
          <div>
            <h3>{{ c.first_name }} {{ c.last_name }}</h3>
            <p>{{ c.email }}</p>
          </div>
        </router-link>
      </template>
      <Spinner v-else text="" class=""/>
    </div>
  </div>
</template>

<style scoped>

</style>
