<template>
  <div class="rounded-md p-2 border-b border-gray-200">
    <div class="w-full p-2 rounded-t-md flex flex-row justify-between">
      <button
        class="
          px-4
          py-2
          text-sm
          font-medium
          text-red-900
          bg-red-100
          border border-transparent
          rounded-md
          hover:bg-red-200
          focus:outline-none
          focus-visible:ring-2
          focus-visible:ring-offset-2
          focus-visible:ring-blue-500
        "
        @click="isOpenDeleteModal = true"
      >
        Supprimer mon compte
      </button>
      <DeleteModal
        title="Êtes vous sûr de vouloir supprimer votre compte"
        success-delete-message="Votre compte a été supprimé avec succès"
        :isOpen="isOpenDeleteModal"
        @close:modal="isOpenDeleteModal = false"
        @delete:success="deleteAccount"
      />
      <div>
        <button
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
            focus-visible:ring-blue-500
            mr-4
          "
          @click="isOpenUpdateUserModal = true"
        >
          Mettre à jour mon compte
        </button>
        <UpdateUserModal
          :isOpen="isOpenUpdateUserModal"
          :userData="userData"
          @close:modal="isOpenUpdateUserModal = false"
        />
        <button
          class="
            px-4
            py-2
            text-sm
            font-medium
            text-green-900
            bg-green-100
            border border-transparent
            rounded-md
            hover:bg-green-200
            focus:outline-none
            focus-visible:ring-2
            focus-visible:ring-offset-2
            focus-visible:ring-blue-500
          "
          @click="isOpenCreateUserModal = true"
        >
          Créer un compte
        </button>
        <CreateUserModal
          :isOpen="isOpenCreateUserModal"
          :userData="userData"
          @close:modal="isOpenCreateUserModal = false"
        />
      </div>
    </div>
  </div>
</template>

<script lang="ts">
import { defineComponent, onMounted, reactive, ref } from "vue";
// User component Modal
import DeleteModal from "@/components/DeleteModal.vue";
import UpdateUserModal from "@/components/user/UpdateUserModal.vue";
import CreateUserModal from "@/components/user/CreateUserModal.vue";
// user store
import { userStore } from "@/store/user";
// global types
import { User } from "@/types/global";
import { apiServer } from "../../api/apiServer";
import { useToast } from "vue-toastification";
// import vue router
import { useRouter } from "vue-router";

export default defineComponent({
  components: {
    DeleteModal,
    UpdateUserModal,
    CreateUserModal,
  },
  setup() {
    const isOpenDeleteModal = ref(false);
    const isOpenUpdateUserModal = ref(false);
    const isOpenCreateUserModal = ref(false);

    const toast = useToast();

    const router = useRouter();

    const userData = reactive<User>({
      username: "",
      email: "",
      id: "",
    });

    onMounted(() => {
      // on mounted fill the user profile with the UserStore data
      const { username, email, id } = userStore.getState();
      userData.id = id;
      userData.username = username;
      userData.email = email;
    });

    const deleteAccount = () => {
      apiServer.users
        .deleteProfil()
        .then(() => {
          userStore.logout();
          router.push("/login");
        })
        .catch(() => {
          toast.error("Oops une erreur s'est produite..");
        });
    };

    return {
      userStoreState: userStore.getState(),
      isOpenDeleteModal,
      isOpenUpdateUserModal,
      isOpenCreateUserModal,
      userData,
      deleteAccount,
    };
  },
});
</script>
