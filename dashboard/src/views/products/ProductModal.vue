<script setup lang="ts">
import { computed, onUpdated, ref, Ref} from "vue";
import { Dialog, DialogPanel, DialogTitle, TransitionChild, TransitionRoot } from "@headlessui/vue";
import { IProduct } from "../../types/product";
import CustomInput from "../../components/core/CustomInput.vue";
import { useProductStore } from "../../store/product.store";
import Spinner from "../../components/core/Spinner.vue";
import CustomChecked from "@/components/core/CustomChecked.vue";

const productStore = useProductStore();

const props = defineProps({
  modelValue: Boolean,
  product: {
    required: true,
    type: Object,
  }
});

const emit = defineEmits(["update:modelValue", "close"])

const product: Ref<IProduct> = ref({
  id: props.product.id,
  title: props.product.title,
  slug: props.product.slug,
  image: props.product.image,
  description: props.product.description,
  price: props.product.price,
  published: props.product.published,
  created_at: props.product.created_at,
  updated_at: props.product.updated_at
});

const loading = computed(() => productStore.loading);

const show = computed({
  get: () => props.modelValue,
  set: (value) => emit("update:modelValue", value)
});

onUpdated(() => {
  console.log(props.product);
  product.value = {
    id: props.product.id,
    title: props.product.title,
    slug: props.product.slug,
    image: props.product.image,
    description: props.product.description,
    price: props.product.price,
    published: props.product.published,
    created_at: props.product.created_at,
    updated_at: props.product.updated_at
  };

  console.log(product.value);
});

const closeModal = () => {
  show.value = false
  emit("close")
}

const onSubmit = async () => {
  if (product.value.id) {
    console.log(product.value);
    await productStore.updateItem(product.value);
    closeModal();
  } else {
    await productStore.addItem(product.value);
    closeModal();
  }
}
</script>

<template>
  <TransitionRoot as="template" :show="show">
    <Dialog as="div" class="relative z-10" @close="show = false">
      <TransitionChild
				as="template"
				enter="ease-out duration-300"
				enter-from="opacity-0"
				enter-to="opacity-100"
        leave="ease-in duration-200"
				leave-from="opacity-100"
				leave-to="opacity-0"
			>
        <div
					class="fixed inset-0 bg-black bg-opacity-70 transition-opacity"
				/>
      </TransitionChild>

      <div class="fixed z-10 inset-0 overflow-y-auto">
        <div class="flex items-end sm:items-center justify-center min-h-full p-4 text-center sm:p-0">
          <TransitionChild
						as="template"
						enter="ease-out duration-300"
            enter-from="opacity-0 translate-y-4 sm:translate-y-0 sm:scale-95"
            enter-to="opacity-100 translate-y-0 sm:scale-100"
						leave="ease-in duration-200"
            leave-from="opacity-100 translate-y-0 sm:scale-100"
            leave-to="opacity-0 translate-y-4 sm:translate-y-0 sm:scale-95"
					>
            <DialogPanel
              class="relative bg-white rounded-lg text-left overflow-hidden shadow-xl transform transition-all sm:my-8 sm:max-w-[700px] sm:w-full"
						>
              <Spinner
								v-if="loading"
                class="absolute left-0 top-0 bg-white right-0 bottom-0 flex items-center justify-center"
							/>
              <header class="py-3 px-4 flex justify-between items-center">
                <DialogTitle as="h3" class="text-lg leading-6 font-medium text-gray-900">
                  {{ product.id ? `Update product: "${props.product.title}"` : 'Create new Product' }}
                </DialogTitle>
                <button
                  @click="closeModal()"
                  class="w-8 h-8 flex items-center justify-center rounded-full transition-colors cursor-pointer hover:bg-[rgba(0,0,0,0.2)]"
                >
                  <svg
                    xmlns="http://www.w3.org/2000/svg"
                    class="h-6 w-6"
                    fill="none"
                    viewBox="0 0 24 24"
                    stroke="currentColor"
                  >
                    <path
                      stroke-linecap="round"
                      stroke-linejoin="round"
                      stroke-width="2"
                      d="M6 18L18 6M6 6l12 12"
                    />
                  </svg>
                </button>
              </header>
              <form @submit.prevent="onSubmit" enctype="multipart/form-data">
                <div class="bg-white px-4 pt-5 pb-4">
                  <CustomInput
                    class="mb-2"
                    :modelValue="product.title"
                    label="Product Title"
                    @update="title => product.title = title"
                  />
                  <CustomInput
                    type="file"
                    class="mb-2"
                    label="Product Image"
                    @change="file => product.image = file"
                  />
                  <CustomInput
                    type="textarea"
                    class="mb-2"
                    :modelValue="product.description"
                    label="Description"
                    @update="description => product.description = description"
                  />
                  <CustomInput
                    type="number"
                    class="mb-2"
                    :modelValue="product.price"
                    label="Price"
                    prepend="$"
                    @update="price => product.price = price"
                  />
                  <CustomChecked
                    class="mb-2"
                    :modelValue="product.published"
                    label="Published"
                    @update="published => product.published = published"
                  />
                </div>
                <footer class="bg-gray-50 px-4 py-3 sm:px-6 sm:flex sm:flex-row-reverse">
                  <button
										type="submit"
                    class="py-2 px-4 border border-transparent text-sm font-medium rounded-md text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500 ml-3"
									>
                    Submit
                  </button>
                  <button
										type="button"
                    class="mt-3 w-full inline-flex justify-center rounded-md border border-gray-300 shadow-sm px-4 py-2 bg-white text-base font-medium text-gray-700 hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500 sm:mt-0 sm:ml-3 sm:w-auto sm:text-sm"
                    @click="closeModal"
										ref="cancelButtonRef"
									>
                    Cancel
                  </button>
                </footer>
              </form>
            </DialogPanel>
          </TransitionChild>
        </div>
      </div>
    </Dialog>
  </TransitionRoot>
</template>

<style scoped></style>