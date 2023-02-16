<script setup lang="ts">
import { Bars3Icon, ArrowDownOnSquareIcon, UserIcon } from "@heroicons/vue/24/outline";
import { Menu, MenuButton, MenuItems, MenuItem } from "@headlessui/vue";
import { ChevronDownIcon } from "@heroicons/vue/24/solid";
import router from "../router";
import { useUserStore } from "../store";

const userStore = useUserStore();

const logout = async () => {
  const res = await userStore.logout();
  if(res){
    await router.push({ name: "login" });
  }
};
</script>

<template>
<header class="flex justify-between items-center p-3 h-14 shadow bg-white">
    <button
      class="flex items-center justify-center rounded transition-colors w-8 h-8 text-gray-700 hover:bg-black/10">
      <Bars3Icon class="w-6"/>
    </button>
    <Menu as="div" class="relative inline-block text-left">
      <MenuButton class="flex items-center">
        <img src="https://randomuser.me/api/portraits/men/1.jpg" class="rounded-full w-8 mr-2">
        <small>{{ "alex" }}</small>
        <ChevronDownIcon
          class="h-5 w-5 text-violet-200 hover:text-violet-100"
          aria-hidden="true"
        />
      </MenuButton>

      <transition
        enter-active-class="transition duration-100 ease-out"
        enter-from-class="transform scale-95 opacity-0"
        enter-to-class="transform scale-100 opacity-100"
        leave-active-class="transition duration-75 ease-in"
        leave-from-class="transform scale-100 opacity-100"
        leave-to-class="transform scale-95 opacity-0"
      >
        <MenuItems
          class="absolute right-0 mt-2 w-36 origin-top-right divide-y divide-gray-100 rounded-md bg-white shadow-lg ring-1 ring-black ring-opacity-5 focus:outline-none"
        >
          <div class="px-1 py-1">
            <MenuItem v-slot="{ active }">
              <button
                :class="[
                  active ? 'bg-indigo-600 text-white' : 'text-gray-900',
                  'group flex w-full items-center rounded-md px-2 py-2 text-sm',
                ]"
              >
                <UserIcon
                  :active="active"
                  class="mr-2 h-5 w-5 text-indigo-400"
                  aria-hidden="true"
                />
                Profile
              </button>
            </MenuItem>
            <MenuItem v-slot="{ active }">
              <button
                :class="[
                  active ? 'bg-indigo-600 text-white' : 'text-gray-900',
                  'group flex w-full items-center rounded-md px-2 py-2 text-sm',
                ]"
                @click="logout"
              >
                <ArrowDownOnSquareIcon
                  :active="active"
                  class="mr-2 h-5 w-5 text-indigo-400"
                  aria-hidden="true"
                />
                Logout
              </button>
            </MenuItem>
          </div>
        </MenuItems>
      </transition>
    </Menu>
  </header>
</template>

<style scoped>
</style>