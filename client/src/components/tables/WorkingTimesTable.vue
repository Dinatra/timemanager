<!-- eslint-disable max-len -->

<template>
  <div class="h-full w-full bg-white rounded-md shadow-sm overflow-scroll">
    <table class="items-center w-full bg-transparent">
      <thead>
        <tr>
          <th
            class="
              px-6
              align-middle
              rounded-tl-md
              py-3
              text-xs
              uppercase
              border-l-0 border-r-0
              whitespace-nowrap
              text-left
              bg-blue-500
              text-white
              border-blue-700
            "
          >
            Label de la tâche
          </th>
          <th
            class="
              px-6
              align-middle
              py-3
              text-xs
              uppercase
              border-l-0 border-r-0
              whitespace-nowrap
              font-semibold
              text-left
              bg-blue-500
              text-white
              border-blue-700
            "
          >
            Date de début
          </th>
          <th
            class="
              px-6
              align-middle
              py-3
              text-xs
              uppercase
              border-l-0 border-r-0
              whitespace-nowrap
              font-semibold
              text-left
              bg-blue-500
              text-white
              border-blue-700
            "
          >
            Date de fin
          </th>
          <th
            class="
              px-6
              align-middle
              py-3
              text-xs
              uppercase
              border-l-0 border-r-0
              whitespace-nowrap
              font-semibold
              text-left
              bg-blue-500
              text-white
              border-blue-700
            "
          >
            Temps de pause
          </th>
          <th
            class="
              px-6
              align-middle
              py-3
              text-xs
              rounded-tr-md
              uppercase
              border-l-0 border-r-0
              whitespace-nowrap
              font-semibold
              text-left
              bg-blue-500
              text-white
              border-blue-700
            "
          ></th>
        </tr>
      </thead>

      <tbody>
        <div v-if="!WTStoreState.workingTimes.length > 0">Loading..</div>
        <working-times-row
          v-else
          @delete:workingTime="deleteWorkingTime"
          v-for="(workingTime, i) in WTStoreState.workingTimes"
          :key="i"
          :data="workingTime"
        />
      </tbody>
    </table>
    <DeleteModal
      title="Êtes vous sur de vouloir supprimer ce temps de travail ?"
      success-delete-message="Temps de travail supprimé avec succès"
      :isOpen="isOpenDeleteWTModal"
      @close:modal="isOpenDeleteWTModal = false"
      @delete:success="deleteWorkingTime"
    />
  </div>
</template>

<script lang="ts">
import { defineComponent, ref, onMounted } from "vue";
import WorkingTimesRow from "@/components/tables/WorkingTimesRow.vue";
import DeleteModal from "@/components/DeleteModal.vue";
// Store
import { workingTimeStore } from "@/store/workingtime";

export default defineComponent({
  components: { WorkingTimesRow, DeleteModal },

  setup() {
    const isOpenDeleteWTModal = ref<boolean>(false);
    var idOfWTBeingUpdated = "";

    const deleteWorkingTime = (id: string) => {
      isOpenDeleteWTModal.value = true;

      if (id) {
        idOfWTBeingUpdated = id;
      } else {
        workingTimeStore.deleteById(idOfWTBeingUpdated);
        idOfWTBeingUpdated = "";
        isOpenDeleteWTModal.value = false;
      }
    };

    onMounted(() => {
      workingTimeStore.fetchAllWorkingTimes();
    });

    return {
      isOpenDeleteWTModal,
      WTStoreState: workingTimeStore.getState(),
      deleteWorkingTime,
    };
  },
});
</script>
