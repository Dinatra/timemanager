<template>
  <TransitionRoot appear :show="isOpen" as="template">
    <Dialog as="div" @close="closeModal">
      <div class="fixed inset-0 z-10 overflow-y-auto">
        <div class="min-h-screen px-4 text-center">
          <TransitionChild
            as="template"
            enter="duration-300 ease-out"
            enter-from="opacity-0"
            enter-to="opacity-300"
            leave="duration-200 ease-in"
            leave-from="opacity-300"
            leave-to="opacity-0"
          >
            <DialogOverlay
              class="
                fixed
                inset-0
                bg-blue-300
                backdrop-filter
                bg-opacity-10
                backdrop-blur-md
              "
            />
          </TransitionChild>

          <span class="inline-block h-screen align-middle" aria-hidden="true">
            &#8203;
          </span>

          <TransitionChild
            as="template"
            enter="duration-300 ease-out"
            enter-from="opacity-0 scale-95"
            enter-to="opacity-100 scale-100"
            leave="duration-200 ease-in"
            leave-from="opacity-100 scale-100"
            leave-to="opacity-0 scale-95"
          >
            <div
              class="
                inline-block
                w-2/3
                p-6
                my-8
                overflow-hidden
                text-left
                align-middle
                transition-all
                transform
                bg-white
                shadow-xl
                rounded-2xl
              "
            >
              <DialogTitle
                as="h3"
                class="text-lg font-medium leading-6 text-gray-900"
              >
                Création d'un équipe
              </DialogTitle>
              <div class="mt-10 flex">
                <form action="" class="w-1/2">
                  <div class="mb-3">
                    <label
                      for="email"
                      class="text-sm font-medium text-gray-900 block mb-2"
                      >Nom de l'équipe</label
                    >
                    <input
                      type="text"
                      id="email"
                      class="
                        bg-gray-50
                        border border-gray-200
                        text-gray-900
                        sm:text-sm
                        rounded-lg
                        focus:ring-blue-500 focus:border-blue-500
                        block
                        w-full
                        p-2.5
                      "
                      v-model="teamName"
                      placeholder="Votre nom d'équipe.."
                      required
                    />
                  </div>
                  <div class="mb-3">
                    <label
                      for="username"
                      class="text-sm font-medium text-gray-900 block mb-2"
                      >Ajouter des nouvelles tâches</label
                    >
                    <div class="relative flex flex-row">
                      <input
                        type="email"
                        id="email"
                        class="
                          bg-gray-50
                          border border-gray-200
                          text-gray-900
                          sm:text-sm
                          rounded-lg
                          focus:ring-blue-500 focus:border-blue-500
                          block
                          w-full
                          p-2.5
                        "
                        v-model="taskName"
                        placeholder="Faire les évaluations.."
                        required
                      />
                      <div
                        class="
                          w-10
                          h-full
                          p-2
                          bg-blue-200
                          rounded-md
                          absolute
                          right-0
                          top-O
                          flex
                          items-center
                        "
                        @click="createNewTask"
                      >
                        <PlusIcon class="text-blue-500 cursor-pointer" />
                      </div>
                    </div>
                  </div>
                </form>
                <div class="w-1/2 pl-4 border-l ml-8">
                  <div class="pb-4">
                    <div v-for="(task, i) in taskList" :key="i">
                      <p>{{ task }}</p>
                    </div>
                  </div>
                </div>
              </div>

              <div class="mt-8 flex justify-end w-1/2 mr-auto">
                <button
                  type="button"
                  class="
                    inline-flex
                    justify-center
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
                    focus-visible:ring-red-500
                    mr-4
                  "
                  @click="closeModal"
                >
                  Annuler
                </button>
                <button
                  type="button"
                  class="
                    inline-flex
                    justify-center
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
                    focus-visible:ring-green-500
                  "
                  @click="sendCreateForm"
                >
                  Valider
                </button>
              </div>
            </div>
          </TransitionChild>
        </div>
      </div>
    </Dialog>
  </TransitionRoot>
</template>

<script lang="ts">
import { defineComponent, reactive, toRefs, ref } from "vue";
// Headless UI import
import {
  TransitionRoot,
  TransitionChild,
  Dialog,
  DialogOverlay,
  DialogTitle,
} from "@headlessui/vue";
// toaster import
import { useToast } from "vue-toastification";
// Heroicon import
import { PlusIcon } from "@heroicons/vue/solid";
// store
import { teamStore } from "@/store/team";
import { Task, Team } from "@/types/global";
import { apiServer } from "../../api/apiServer";

export default defineComponent({
  props: {
    isOpen: Boolean,
  },
  components: {
    TransitionRoot,
    TransitionChild,
    Dialog,
    DialogOverlay,
    DialogTitle,
    // Icons
    PlusIcon,
  },
  setup(_, { emit }) {
    const toast = useToast();

    const closeModal = () => {
      emit("close:modal");
    };

    const formData = reactive({
      teamName: "",
      taskName: "",
      confirmPassword: "",
    });

    const taskList = ref<string[]>([]);

    const sendCreateForm = () => {
      const isTeamNameValid = formData.teamName.length > 0;
      const isFormUnvalid = [isTeamNameValid].includes(false);

      if (!isFormUnvalid) {
        const tasks: Task[] = taskList.value.map((task) => {
          const newTask: Task = { name: task, complete: false };
          return newTask;
        });

        const team: Team = {
          name: formData.teamName,
          owner: "mehdi",
          users: [],
          tasks,
        };
        apiServer.teams
          .createNewTeam(team)
          .then(() => {
            toast.success("Votre équipe a été créée avec succès");
            closeModal();
          })
          .catch(() => {
            toast.error(
              "Une erreur est survenue lors de la création de l'équipe"
            );
          });
        // teamStore.createTeam(team);
        closeModal();
      } else {
        toast.error("Les informations du formulaire sont incorrectes");
      }
    };

    const createNewTask = () => {
      taskList.value.push(formData.taskName);
      formData.taskName = "";
    };

    return {
      closeModal,
      sendCreateForm,
      ...toRefs(formData),
      taskList,
      createNewTask,
    };
  },
});
</script>
