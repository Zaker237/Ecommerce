<script setup lang="ts">
import {computed, onMounted, ref} from "vue";
import ProductModal from "./ProductModal.vue";
import ProductsTable from "./ProductsTable.vue";
import { useProductStore } from "../../store/product.store.ts";

const productStore = useProductStore();

const DEFAULT_PRODUCT = {
  id: "",
  title: "",
  description: "",
  image: "",
  price: ""
}
const products = computed(() => productStore.products);
const productModel = ref({...DEFAULT_PRODUCT})
const showProductModal = ref(false);

const showAddNewModal = () => {
  showProductModal.value = true
}
const editProduct = (p) => {
  productStore.getItem(p.id)
    .then(({data}) => {
      productModel.value = data
      showAddNewModal();
    })
}

const onModalClose = () => {
  productModel.value = {...DEFAULT_PRODUCT}
}
</script>

<template>
  <div class="flex items-center justify-between mb-3">
    <h1 class="text-3xl font-semibold">Products</h1>
    <button
			type="button"
      @click="showAddNewModal()"
      class="py-2 px-4 border border-transparent text-sm font-medium rounded-md text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500"
    >
      Add new Product
    </button>
  </div>
  <ProductsTable @clickEdit="editProduct"/>
  <ProductModal
		v-model="showProductModal"
		:product="productModel"
		@close="onModalClose"
	/>
</template>

<style scoped>
</style>