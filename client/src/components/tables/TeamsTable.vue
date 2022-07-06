<!-- eslint-disable max-len -->

<template>
  <div class="h-full w-full flex flex-col">
    <button
      type="button"
      class="
        px-4
        py-2
        text-sm
        font-medium
        text-blue-900
        bg-blue-100
        border border-transparent
        rounded-md
        hover:bg-blue-200
        focus:outline-none
        focus-visible:ring-2
        focus-visible:ring-offset-2
        focus-visible:ring-green-500
        ml-auto
        mb-4
      "
      @click="isOpenCreateModal = true"
      v-if="UserStoreState.role === 'manager'"
    >
      Créer une team
    </button>
    <CreateTeamModal
      :isOpen="isOpenCreateModal"
      @close:modal="isOpenCreateModal = false"
    />
    <table class="items-center w-full bg-white shadow-sm">
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
            Nom
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
            Nombre de tâches
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
            Nombre d'utilisateur
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
            Manager
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
            Tâches restante
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
        <div v-if="!TeamStoreState.teams.length > 0">Loading..</div>
        <TeamsRow
          v-else
          @delete:team="deleteTeam"
          v-for="(team, i) in TeamStoreState.teams"
          :key="i"
          :team="team"
        />
      </tbody>
    </table>
    <DeleteModal
      title="Êtes vous sûr de vouloir quitter cette équipe ?"
      success-delete-message="Vous avez quitter votre team"
      :isOpen="isOpenDeleteModal"
      @close:modal="isOpenDeleteModal = false"
      @delete:success="deleteTeam"
    />
  </div>
</template>

<script lang="ts">
import { defineComponent, onMounted, ref } from "vue";
import TeamsRow from "@/components/tables/TeamsRow.vue";
import DeleteModal from "@/components/DeleteModal.vue";
import CreateTeamModal from "@/components/team/CreateTeamModal.vue";
// Store
import { teamStore } from "@/store/team";
import { userStore } from "@/store/user";
import { apiServer } from "../../api/apiServer";

export default defineComponent({
  components: { TeamsRow, DeleteModal, CreateTeamModal },

  setup() {
    const isOpenDeleteModal = ref<boolean>(false);
    const isOpenCreateModal = ref<boolean>(false);

    onMounted(() => {
      teamStore.fetchAllTeams();
    });

    var idOfTeamBeingUpdated = "";

    const deleteTeam = (id: string) => {
      console.log("je suis call avec", id);

      isOpenDeleteModal.value = true;

      if (id) {
        idOfTeamBeingUpdated = id;
      } else {
        apiServer.teams.current_leaveUserTeam(idOfTeamBeingUpdated).then(() => {
          teamStore.fetchAllTeams();
        });

        teamStore.deleteById(idOfTeamBeingUpdated);
        idOfTeamBeingUpdated = "";
        isOpenDeleteModal.value = false;
      }
    };

    return {
      isOpenDeleteModal,
      isOpenCreateModal,
      TeamStoreState: teamStore.getState(),
      UserStoreState: userStore.getState(),
      deleteTeam,
    };
  },
});
</script>
