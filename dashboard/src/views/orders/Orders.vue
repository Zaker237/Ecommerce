<script setup lang="ts">
import {computed, onMounted, ref} from "vue";
import OrdersTable from "./OrdersTable.vue";
import { useOrderStore } from "../../store/order.store";
import { IOrder } from "../../types/order";

const orderStore = useOrderStore();

const orders = computed(() => orderStore.items);

onMounted(async () => {
  await orderStore.getItems({});
});

const showOrder = (order: IOrder) => {
  console.log(order);
}
</script>

<template>
	<div class="flex items-center justify-between mb-3">
    <h1 class="text-3xl font-semibold">Orders</h1>
  </div>
  <OrdersTable @clickView="showOrder"/>
</template>

<style scoped></style>