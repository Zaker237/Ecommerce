<script setup lang="ts">
import { IOrder } from "../../types/order";

const {order} = defineProps({
  order: {
    required: true,
    type: Object
  }
})

const bgColor = () => {
  if(['paid', 'completed'].includes(order.status)){
    return "bg-emerald-500";
  }else if(order.status === "shipped"){
    return "bg-orange-400";
  }else if(order.status === "cancelled"){
    return "bg-red-500";
  }else if(order.status === "unpaid"){
    return "bg-gray-400";
  }else{
    return "";
  }
}
</script>

<template>
	<span :class="'text-white py-1 px-2 rounded ' + bgColor()">
		{{ order.status }}
	</span>
</template>

<style scoped></style>