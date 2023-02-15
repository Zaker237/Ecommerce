<script setup lang="ts">
import { computed, ref } from "vue";

const emit = defineEmits(["update:modelValue", "change"]);

const props = defineProps({
  modelValue: Boolean,
  label: String,
  name: String,
  required: Boolean,
  prepend: {
    type: String,
    default: ''
  },
  append: {
    type: String,
    default: ''
  },
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

const inputClasses = computed(() => {
  const cls = [
    `block w-full px-3 py-2 border border-gray-300 placeholder-gray-500 text-gray-900 focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 focus:z-10 sm:text-sm`,
  ];
  if (props.append && !props.prepend) {
    cls.push(`rounded-l-md`)
  } else if (props.prepend && !props.append) {
    cls.push(`rounded-r-md`)
  } else if (!props.prepend && !props.append) {
    cls.push('rounded-md')
  }
  return cls.join(' ')
});

const handleCheckedChange = (event: Event) => {
  return (event.target as HTMLInputElement).checked
}
</script>

<template>
  <div>
    <label class="sr-only">{{ label }}</label>
    <div class="mt-1 flex rounded-md shadow-sm">
      <span v-if="prepend"
        class="inline-flex items-center px-3 rounded-l-md border border-r-0 border-gray-300 bg-gray-50 text-gray-500 text-sm"
      >
        {{ prepend }}
      </span>
      <template>
        <input
          :id="id"
          :name="name"
          type="checkbox"
          :checked="props.modelValue"
          :required="required"
          @change="emit('update:modelValue', handleCheckedChange($event))"
          class="h-4 w-4 text-indigo-600 focus:ring-indigo-500 border-gray-300 rounded"
        />
        <label :for="id" class="ml-2 block text-sm text-gray-900"> {{ label }} </label>
      </template>
      <span v-if="append"
        class="inline-flex items-center px-3 rounded-r-md border border-l-0 border-gray-300 bg-gray-50 text-gray-500 text-sm"
      >
        {{ append }}
      </span>
    </div>
  </div>
</template>

<style scoped></style>
