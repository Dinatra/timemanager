<!-- eslint-disable max-len -->

<template>
  <DashboardLayout>
    <div class="flex flex-row flex-wrap">
      <div class="w-full md:w-1/2 h-92 p-8">
        <UserDashWelcome />
      </div>
      <div class="w-full md:w-1/2 h-96 p-8">
        <div class="h-full w-full bg-white rounded-md">
          <DailyChart />
        </div>
      </div>
      <div class="w-full md:w-1/1 h-96 p-8">
        <div class="h-full w-full bg-white rounded-md">
          <ChartManagerWeekly />
        </div>
      </div>
      <!-- <div class="w-full md:w-1/2 h-96 p-8">
        <div class="h-full w-full bg-white rounded-md">
        </div>
      </div> -->
      <!-- <div class="w-full md:w-1/2 h-96 p-8">
        <div class="h-full w-full bg-white rounded-md"></div>
      </div>
      <div class="w-full md:w-1/2 h-96 p-8">
        <div class="h-full w-full bg-white rounded-md"></div>
      </div>
      <div class="w-full md:w-1/2 h-96 p-8">
        <div class="h-full w-full bg-white rounded-md"></div>
      </div> -->
    </div>
  </DashboardLayout>
</template>

<script lang="ts">
import { defineComponent } from "vue";

import DailyChart from "@/components/manager/DailyChart.vue";
import DashboardLayout from "@/layouts/DashboardLayout.vue";
import UserDashWelcome from "@/components/user/UserDashWelcome.vue";
import ChartManagerWeekly from "@/components/manager/ChartManagerWeekly.vue";

export default defineComponent({
  components: {
    DailyChart,
    DashboardLayout,
    UserDashWelcome,
    ChartManagerWeekly,
  },
});
</script>
