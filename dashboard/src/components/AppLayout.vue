<script lang="ts" setup>
import { Ref, ref, computed, onMounted, onUnmounted } from 'vue'
import Sidebar from "./Sidebar.vue";
import Navbar from "./Navbar.vue";

const sidebarOpened: Ref<boolean> = ref(true);

const toggleSidebar = () => {
  sidebarOpened.value = !sidebarOpened.value
}

</script>

<template>
  <div class="min-h-full bg-gray-200 flex">
    <!--    Sidebar-->
    <Sidebar :class="{'-ml-[200px]': !sidebarOpened}"/>
    <!--/    Sidebar-->

    <div class="flex-1">
      <Navbar @toggle-sidebar="toggleSidebar"></Navbar>
      <!--      Content-->
      <main class="p-6">
        <router-view></router-view>
      </main>
      <!--      Content-->
    </div>
  </div>
</template>

<style scoped>
</style>