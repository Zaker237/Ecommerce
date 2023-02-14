<script setup lang="ts">
import {computed, Ref, ref} from "vue";
import { IUser } from "../../types/user";
import { useUserStore } from "../../store/user.store";
import UserModal from "./UserModal.vue";
import UsersTable from "./UsersTable.vue";

const userStore = useUserStore();

const DEFAULT_USER = {
  id: 0,
  name: '',
  email: '',
  created_at: ''
}

const users = computed(() => userStore.items);
const userModel: Ref<IUser> = ref({...DEFAULT_USER})
const showUserModal = ref(false);

const showAddNewModal = () => {
  showUserModal.value = true
}

const editUser = (user: IUser) => {
  userModel.value = user;
  showAddNewModal();
}

const onModalClose = () => {
  userModel.value = {...DEFAULT_USER}
}
</script>

<template>
	<div class="flex items-center justify-between mb-3">
    <h1 class="text-3xl font-semibold">Users</h1>
    <button
			type="button"
      @click="showAddNewModal()"
      class="py-2 px-4 border border-transparent text-sm font-medium rounded-md text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500"
    >
      Add new User
    </button>
  </div>
  <UsersTable @clickEdit="editUser"/>
  <UserModal
		v-model="showUserModal"
		:user="userModel"
		@close="onModalClose"
	/>
</template>

<style scoped></style>