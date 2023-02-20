<script setup lang="ts">
import { computed } from "vue";

const emit = defineEmits(["update"]);

const props = defineProps({
  modelValue: [Boolean],
  label: String,
  name: String,
  required: Boolean,
  selectOptions: Array,
  id: {
    type: String,
    default: ''
  }
});

const id = computed(() => {
  if (props.id){
    return props.id;
  }
  return `id-${Math.floor(1000000 + Math.random() * 1000000)}`;
});

const handleCheckedChange = (event: Event) => {
  return (event.target as HTMLInputElement).checked;
}
</script>

<template>
  <div>
    <label class="sr-only">{{ label }}</label>
    <div class="mt-1 flex rounded-md shadow-sm">
      <input
        :id="id"
        :name="name"
        type="checkbox"
        :checked="props.modelValue"
        class="h-4 w-4 text-indigo-600 focus:ring-indigo-500 border-gray-300 rounded"
        @change="emit('update', handleCheckedChange($event))"
      />
      <label :for="name" class="ml-2 block text-sm text-gray-900"> {{ label }} </label>
    </div>
  </div>
</template>

<style scoped></style>
