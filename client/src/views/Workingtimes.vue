<!-- eslint-disable max-len -->
<template>
  <DashboardLayout>
    <div class="flex flex-row flex-wrap">
      <div class="w-full p-8">
        <working-times-table />
      </div>
    </div>
  </DashboardLayout>
</template>

<script lang="ts">
import { defineComponent } from "vue";

import DashboardLayout from "@/layouts/DashboardLayout.vue";
import WorkingTimesTable from "@/components/tables/WorkingTimesTable.vue";

export default defineComponent({
  components: {
    DashboardLayout,
    WorkingTimesTable,
  },
});
</script>
