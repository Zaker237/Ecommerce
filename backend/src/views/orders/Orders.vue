<script setup lang="ts">
import {computed, onMounted, ref} from "vue";
import store from "../../store";
import OrdersTable from "./OrdersTable.vue";

const orders = computed(() => store.state.orders);
const showOrder = (p) => {

}
</script>

<template>
	<div class="flex items-center justify-between mb-3">
    <h1 class="text-3xl font-semibold">Orders</h1>
  </div>
  <OrdersTable @clickView="viewOrder"/>
</template>

<style scoped></style>