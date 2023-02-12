<script setup lang="ts">
import {UserIcon} from '@heroicons/vue/outline'
import DoughnutChart from '../components/core/Charts/Doughnut.vue'
import axiosClient from "../axios.js";
import {onMounted, ref, Ref} from "vue";
import Spinner from "../components/core/Spinner.vue";
import { IDateOptions } from "../types/dashboard";
import CustomInput from "../components/core/CustomInput.vue";

const dateOptions: Ref<IDateOptions[]> = ref([
  {key: '1d', text: 'Last Day'},
  {key: '1k', text: 'Last Week'},
  {key: '2k', text: 'Last 2 Weeks'},
  {key: '1m', text: 'Last Month'},
  {key: '3m', text: 'Last 3 Months'},
  {key: '6m', text: 'Last 6 Months'},
  {key: 'all', text: 'All Time'},
]);

const chosenDate: Ref<String> = ref('all');

const loading = ref({
  customersCount: true,
  productsCount: true,
  paidOrders: true,
  totalIncome: true,
  ordersByCountry: true,
  latestCustomers: true,
  latestOrders: true
});

const customersCount: Ref<Number> = ref(0);
const productsCount: Ref<Number> = ref(0);
const paidOrders: Ref<Number> = ref(0);
const totalIncome: Ref<Number> = ref(0);
const ordersByCountry = ref([]);
const latestCustomers = ref([]);
const latestOrders = ref([]);

const updateDashboard = () => {
  const d = chosenDate.value
  loading.value = {
    customersCount: true,
    productsCount: true,
    paidOrders: true,
    totalIncome: true,
    ordersByCountry: true,
    latestCustomers: true,
    latestOrders: true
  }
  axiosClient.get(`/dashboard/customers-count`, {params: {d}}).then(({data}) => {
    customersCount.value = data
    loading.value.customersCount = false;
  })
  axiosClient.get(`/dashboard/products-count`, {params: {d}}).then(({data}) => {
    productsCount.value = data;
    loading.value.productsCount = false;
  })
  axiosClient.get(`/dashboard/orders-count`, {params: {d}}).then(({data}) => {
    paidOrders.value = data;
    loading.value.paidOrders = false;
  })
  axiosClient.get(`/dashboard/income-amount`, {params: {d}}).then(({data}) => {
    totalIncome.value = new Intl.NumberFormat('en-US', {style: 'currency', currency: 'USD'})
      .format(data);
    loading.value.totalIncome = false;
  })
  axiosClient.get(`/dashboard/orders-by-country`, {params: {d}}).then(({data: countries}) => {
    loading.value.ordersByCountry = false;
    const chartData = {
      labels: [],
      datasets: [{
        backgroundColor: ['#41B883', '#E46651', '#00D8FF', '#DD1B16'],
        data: []
      }]
    }
    countries.forEach(c => {
      chartData.labels.push(c.name);
      chartData.datasets[0].data.push(c.count);
    })
    ordersByCountry.value = chartData
  })
  axiosClient.get(`/dashboard/latest-customers`, {params: {d}}).then(({data: customers}) => {
    latestCustomers.value = customers;
    loading.value.latestCustomers = false;
  })
  axiosClient.get(`/dashboard/latest-orders`, {params: {d}}).then(({data: orders}) => {
    latestOrders.value = orders.data;
    loading.value.latestOrders = false;
  })
}

const onDatePickerChange = () => {
  updateDashboard();
}
onMounted(() => updateDashboard());
</script>

<template>
	<div>Dasboard</div>
</template>

<style scoped>

</style>
