<template>
  <div>
    <!-- mobile menu -->
    <Tabbar class="visible md:hidden" />

    <!-- desktop menu -->
    <Sidebar class="hidden md:visible" />

    <!-- Stopwatch -->
    <StopWatch />
    <!-- Layout -->
    <div class="mx-auto lg:ml-80 p-4 bg-gray-100 pt-16 md:pt-32 min-h-screen">
      <slot />
    </div>
  </div>
</template>

<script lang="ts">
import { defineComponent } from "vue";
import StopWatch from "@/components/StopWatch.vue";
import Tabbar from "@/components/navbar/Tabbar.vue";
import Sidebar from "@/components/navbar/Sidebar.vue";

export default defineComponent({
  components: {
    StopWatch,
    Tabbar,
    Sidebar,
  },
});
</script>
