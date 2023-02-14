<script setup lang="ts">
import {computed, onMounted, ref, Ref} from "vue";
import { useCustomerStore } from "../../store/customer.store";
import { ICustomer } from "../../types/customer";
import CustomersTable from "./CustomersTable.vue";

const customerStore = useCustomerStore();

const DEFAULT_CUSTOMER = {
	id: 0, first_name: "", last_name: "", email: "",
  phone: "", status: "", created_at:"", updated_at: "",
  billingAddress: {id: 0, address1: "", address2: "", city: "", state: "", zipcode: 0, country_code: ""},
  shippingAddress: {id: 0, address1: "", address2: "", city: "", state: "", zipcode: 0, country_code: ""}
}

const customers = computed(() => customerStore.items);

const customerModel: Ref<ICustomer> = ref(DEFAULT_CUSTOMER); 
const showCustomerModal: Ref<Boolean> = ref(false);

const showAddNewModal = () => {
  showCustomerModal.value = true
}

const editCustomer = async (customer: ICustomer) => {
  const data: ICustomer | null = await customerStore.getItem(String(customer.id));
	console.log(data);
	if(!data) return
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