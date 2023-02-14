<script setup lang="ts">
import {computed, onMounted, ref, Ref} from "vue";
import { useOrderStore } from "../../store/order.store";
import {useRoute} from "vue-router";
import { IOrder } from "../../types/order";
import OrderStatus from "./OrderStatus.vue";

const orderStore = useOrderStore();



const route = useRoute();
const order: Ref<IOrder> = ref({
  id: 0, status: "", total_price:0, created_at:"", updated_at: "",
  items: [],
  customer:{
    id: 0, email: "", first_name: "", last_name: "", phone: "",
    billingAddress: {id: 0, address1: "", address2: "", city: "", state: "", zipcode: 0, country_code: ""},
    shippingAddress: {id: 0, address1: "", address2: "", city: "", state: "", zipcode: 0, country_code: ""}
  }
});
const orderStatuses = computed(() => orderStore.statuse);

onMounted(async () => {
  const data: IOrder | null = await orderStore.getItem(String(route.params.id));
  if(!data) return
  order.value = data;
  await orderStore.getOrderStatuse();
})

const onStatusChange = () => {
  orderStore.updateStatus(order.value.id, order.value.status);
  //store.commit('showToast', `Order status was successfully changed into "${order.value.status}"`)
}
</script>

<template>
	<div v-if="order">
    <!--  Order Details-->
    <div>
      <h2 class="flex justify-between items-center text-xl font-semibold pb-2 border-b border-gray-300">
        Order Details
        <OrderStatus :order="order" />
      </h2>
      <table>
        <tbody>
        <tr>
          <td class="font-bold py-1 px-2">Order #</td>
          <td>{{ order.id }}</td>
        </tr>
        <tr>
          <td class="font-bold py-1 px-2">Order Date</td>
          <td>{{ order.created_at }}</td>
        </tr>
        <tr>
          <td class="font-bold py-1 px-2">Order Status</td>
          <td>
            <select v-model="order.status" @change="onStatusChange">
              <option v-for="status of orderStatuses" :value="status">{{status}}</option>
            </select>
          </td>
        </tr>
        <tr>
          <td class="font-bold py-1 px-2">SubTotal</td>
          <td>${{ order.total_price }}</td>
        </tr>
        </tbody>
      </table>
    </div>
    <!--/  Order Details-->

    <!--  Customer Details-->
    <div>
      <h2 class="text-xl font-semibold mt-6 pb-2 border-b border-gray-300">Customer Details</h2>
      <table>
        <tbody>
        <tr>
          <td class="font-bold py-1 px-2">Full Name</td>
          <td>{{ order?.customer?.first_name }} {{ order?.customer?.last_name }}</td>
        </tr>
        <tr>
          <td class="font-bold py-1 px-2">Email</td>
          <td>{{ order?.customer?.email }}</td>
        </tr>
        <tr>
          <td class="font-bold py-1 px-2">Phone</td>
          <td>{{ order?.customer?.phone }}</td>
        </tr>
        </tbody>
      </table>
    </div>
    <!--/  Customer Details-->

    <!--  Addresses Details-->
    <div class="grid grid-cols-1 md:grid-cols-2 gap-3">
      <div>
        <h2 class="text-xl font-semibold mt-6 pb-2 border-b border-gray-300">Billing Address</h2>
        <!--  Billing Address Details-->
        <div>
          {{ order.customer.billingAddress.address1 }}, {{ order.customer.billingAddress.address2 }} <br>
          {{ order.customer.billingAddress.city }}, {{ order.customer.billingAddress.zipcode }} <br>
          {{ order.customer.billingAddress.state }}, {{ order.customer.billingAddress.country_code }} <br>
        </div>
        <!--/  Billing Address Details-->
      </div>
      <div>
        <h2 class="text-xl font-semibold mt-6 pb-2 border-b border-gray-300">Shipping Address</h2>
        <!--  Shipping Address Details-->
        <div>
          {{ order.customer.shippingAddress.address1 }}, {{ order.customer?.shippingAddress.address2 }} <br>
          {{ order.customer.shippingAddress.city }}, {{ order.customer?.shippingAddress.zipcode }} <br>
          {{ order.customer.shippingAddress.state }}, {{ order.customer?.shippingAddress.country_code }} <br>
        </div>
        <!--/  Shipping Address Details-->
      </div>
    </div>
    <!--/  Customer Details-->

    <!--    Order Items-->
    <div>
      <h2 class="text-xl font-semibold mt-6 pb-2 border-b border-gray-300">Order Items</h2>
      <div v-for="item of order.items">
        <!-- Order Item -->
        <div class="flex flex-col sm:flex-row items-center  gap-4">
          <a href="#"
             class="w-36 h-32 flex items-center justify-center overflow-hidden">
            <img :src="item.product.image" class="object-cover" alt=""/>
          </a>
          <div class="flex flex-col justify-between flex-1">
            <div class="flex justify-between mb-3">
              <h3>
                {{ item.product.title }}
              </h3>
            </div>
            <div class="flex justify-between items-center">
              <div class="flex items-center">Qty: {{ item.quantity }}</div>
              <span class="text-lg font-semibold"> ${{ item.unit_price }} </span>
            </div>
          </div>
        </div>
        <!--/ Order Item -->
        <hr class="my-3"/>
      </div>
    </div>
    <!--/    Order Items-->
  </div>
</template>

<style scoped></style>