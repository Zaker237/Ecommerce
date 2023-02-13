<script setup lang="ts">
import {computed, onMounted, ref, Ref} from "vue";
import { useCustomerStore } from "../../store/customer.store";
import { ICustomer } from "../../types/customer";
import CustomersTable from "./CustomersTable.vue";

const customerStore = useCustomerStore();

const DEFAULT_CUSTOMER = {
}

const customers = computed(() => customerStore.items);
const showCustomerModal: Ref<Boolean> = ref(false);

const showAddNewModal = () => {
  showCustomerModal.value = true
}

const editCustomer = async (customer: ICustomer) => {
  const data: ICustomer = await customerStore.getItem(customer.id);
	console.log(data);
	//customerModel.value = {...data};
	customerModel.value = {
		id: data.id,
		email: data.email,
		first_name: data.first_name,
		last_name: data.last_name,
		phone: data.phone,
		status: data.status,
		created_at: data.created_at,
		updated_at: data.updated_at,
		billingAddress: data.billingAddress,
		shippingAddress: data.shippingAddress
	};
	/*customerModel.value.id = data.id;
	customerModel.value.first_name = data.first_name;
	customerModel.value.last_name = data.last_name;
	customerModel.value.email = data.email;
	customerModel.value.phone = data.phone;
	customerModel.value.status = data.status;
	customerModel.value.created_at = data.created_at;
	customerModel.value.updated_at = data.updated_at;
	customerModel.value.billingAddress = data.billingAddress;
	customerModel.value.shippingAddress = data.shippingAddress;*/
	
	console.log(customerModel.value);
  showAddNewModal();
}

const onModalClose = () => {
  customerModel.value = {...DEFAULT_CUSTOMER}
}
</script>

<template>
	<div class="flex items-center justify-between mb-3">
    <h1 class="text-3xl font-semibold">Customers</h1>
  </div>
  <CustomersTable @clickEdit="editCustomer"/>
</template>

<style scoped></style>