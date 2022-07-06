<!-- eslint-disable max-len -->
<template>
  <DashboardLayout>
    <div class="flex flex-row flex-wrap">
      <div class="w-full p-8">
        <TeamsTable />
      </div>
    </div>
  </DashboardLayout>
</template>

<script lang="ts">
import { defineComponent } from "vue";

import DashboardLayout from "@/layouts/DashboardLayout.vue";
import TeamsTable from "@/components/tables/TeamsTable.vue";

export default defineComponent({
  components: {
    DashboardLayout,
    TeamsTable,
  },
});
</script>
