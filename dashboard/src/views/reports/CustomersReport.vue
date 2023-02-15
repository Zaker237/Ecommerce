<script setup lang="ts">
import {ref, watch, onMounted} from "vue";
import BarChart from "../../components/core/charts/Bar.vue";
import {useRoute} from "vue-router";
import { useReportStore } from "../../store/report.store";

const reportStore = useReportStore();
const route = useRoute();
const chartData = ref([]);

watch(
	route,
	async (rt) => {
  	await getData();
	}
);

const getData = async () => {
  chartData.value = await reportStore.getCustomersReport(String(route.params.date));
}

onMounted(async () => {
	await getData();
})
</script>

<template>
	<BarChart :data="chartData" :height="240" />
</template>

<style scoped></style>