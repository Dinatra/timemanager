<template>
  <div
    class="
      fixed
      w-full
      flex flex-row
      z-30
      md:top-2 md:right-0 md:pr-12 md:w-auto
    "
  >
    <CreateWorkingTimeModal
      :isOpen="isOpenCreateWorkingTimeModal"
      :workingTime="elapsedTime"
      :breakingTime="breakTime"
      :startedAt="startedAt"
      :endedAt="endedAt"
      @close:modal="isOpenCreateWorkingTimeModal = false"
      @created:workingTime="resetStopWatch"
    />
    <div
      class="
        container
        bg-blue-500
        flex flex-row
        items-center
        p-2
        md:w-64 md:rounded-l-md
      "
    >
      <div
        class="p-4 px-6 bg-blue-400 inline-flex rounded-md cursor-pointer"
        v-if="!isRunning"
        @click="startStopWatch"
      >
        <svg
          width="16"
          height="19"
          viewBox="0 0 16 19"
          fill="none"
          class="overflow-visible"
          xmlns="http://www.w3.org/2000/svg"
        >
          <path d="M0 0V19L19 9.5L0 0Z" fill="white" />
        </svg>
      </div>
      <div
        class="p-4 px-6 bg-blue-400 inline-flex rounded-md cursor-pointer"
        v-else
        @click="pauseStopWatch"
      >
        <svg
          width="16"
          height="19"
          viewBox="0 0 16 19"
          fill="none"
          xmlns="http://www.w3.org/2000/svg"
        >
          <path
            d="M0 19H5.33333V0H0V19ZM10.6667 0V19H16V0H10.6667Z"
            fill="white"
          />
        </svg>
      </div>
      <div class="flex flex-col content-center ml-4">
        <p
          class="
            text-white text-xs
            uppercase
            font-thin
            flex flex-row
            items-center
          "
        >
          Temps de travail
          <RefreshIcon
            class="w-5 h-5 ml-2 text-white cursor-pointer"
            @click="resetStopWatch"
          />
        </p>
        <p class="font-medium text-white text-md uppercase">
          {{ formattedElapsedTime }}
        </p>
      </div>
    </div>
    <div
      class="
        p-4
        items-center
        flex
        px-6
        md:rounded-r-md
        bg-blue-400
        cursor-pointer
      "
      @click="publishWorkingTime"
    >
      <svg
        width="24"
        height="24"
        viewBox="0 0 24 24"
        fill="none"
        xmlns="http://www.w3.org/2000/svg"
      >
        <path d="M2.01 21L23 12L2.01 3L2 10L17 12L2 14L2.01 21Z" fill="white" />
      </svg>
    </div>
  </div>
</template>

<script lang="ts">
import { defineComponent, ref, computed } from "vue";
import { useToast } from "vue-toastification";
import { RefreshIcon } from "@heroicons/vue/solid";
import { formatTime } from "@/utils/date";
import CreateWorkingTimeModal from "@/components/workingTime/CreateWorkingTimeModal.vue";

export default defineComponent({
  components: {
    CreateWorkingTimeModal,
    // Heroicon
    RefreshIcon,
  },
  setup() {
    const toast = useToast();
    // StopWatch management
    const timer = ref();
    const isRunning = ref<boolean>(false);
    const elapsedTime = ref<number>(0);
    // end / start of workingTime
    const startedAt = ref<Date | null>(null);
    const endedAt = ref<Date | null>(null);
    // Modal visibility
    const isOpenCreateWorkingTimeModal = ref<boolean>(false);

    const startStopWatch = () => {
      isRunning.value = true;

      if (!elapsedTime.value) startedAt.value = new Date();

      timer.value = setInterval(() => {
        elapsedTime.value += 1000;
      }, 1000);
    };

    const pauseStopWatch = () => {
      isRunning.value = false;
      clearInterval(timer.value);
    };

    const resetStopWatch = () => {
      pauseStopWatch();
      elapsedTime.value = 0;
      startedAt.value = null;
      endedAt.value = null;
    };

    const formattedElapsedTime = computed<string>(() =>
      formatTime(elapsedTime.value)
    );

    const breakTime = computed<number>(() => {
      if (endedAt.value && startedAt.value) {
        const allTime = Math.abs(
          +new Date(startedAt.value.toString()) -
            +new Date(endedAt.value.toString())
        );
        return allTime - elapsedTime.value;
      }

      return NaN;
    });

    const publishWorkingTime = () => {
      if (startedAt.value) {
        if (isRunning.value) pauseStopWatch();

        endedAt.value = new Date();
        isOpenCreateWorkingTimeModal.value = true;
      } else {
        toast.error("Votre chronomètre n'est pas lancé.");
      }
    };

    return {
      isRunning,
      timer,
      startStopWatch,
      pauseStopWatch,
      formattedElapsedTime,
      publishWorkingTime,
      resetStopWatch,
      // breaking and workingtime
      elapsedTime,
      breakTime,
      // Create workingTime modal management
      isOpenCreateWorkingTimeModal,
      startedAt,
      endedAt,
    };
  },
});
</script>
