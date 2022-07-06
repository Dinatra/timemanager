<template>
  <TransitionRoot appear :show="isOpen" as="template">
    <Dialog as="div" @close="closeModal">
      <div class="fixed inset-0 z-20 overflow-y-auto">
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
                w-full
                max-w-md
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
                Sauvegarde de votre temps de travail
              </DialogTitle>
              <p
                class="
                  border-l-4 border-gray-300
                  pl-3
                  text-xs text-gray-300
                  mt-2
                  w-80
                "
              >
                vous pouvez rectifier vos temps de travail ou commentaire dans
                votre espace temps de travail
              </p>
              <div class="mt-10">
                <form action="">
                  <div class="mt-3 mb-3">
                    <label
                      for="workingTime"
                      class="block text-sm font-medium text-gray-700 mb-2"
                    >
                      Temps de travail
                    </label>
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
                      placeholder="Entrez votre tâche.. (optionnel)"
                      required
                    />
                  </div>

                  <div class="mb-3">
                    <div class="flex flex-row justify-between">
                      <div class="flex-1 mr-4">
                        <p class="text-sm font-medium text-gray-900 block mb-2">
                          Temps de pause
                        </p>
                        <div
                          class="
                            bg-gray-50
                            border border-gray-200
                            text-gray-400
                            sm:text-sm
                            rounded-lg
                            block
                            w-full
                            p-2.5
                            cursor-not-allowed
                          "
                        >
                          {{ formatTime(breakingTime) }}
                        </div>
                      </div>
                      <div class="flex-1">
                        <p class="text-sm font-medium text-gray-900 block mb-2">
                          Temps de travail
                        </p>
                        <div
                          class="
                            bg-gray-50
                            border border-gray-200
                            text-gray-400
                            sm:text-sm
                            rounded-lg
                            block
                            w-full
                            p-2.5
                            cursor-not-allowed
                          "
                        >
                          {{ formatTime(workingTime) }}
                        </div>
                      </div>
                    </div>
                  </div>
                  <div class="mb-3">
                    <label
                      for="email"
                      class="text-sm font-medium text-gray-900 block mb-2"
                      >Votre commentaire</label
                    >
                    <textarea
                      type="comments"
                      id="comments"
                      class="
                        bg-gray-50
                        border border-gray-200
                        text-gray-900
                        h-32
                        sm:text-sm
                        rounded-lg
                        focus:ring-blue-500 focus:border-blue-500
                        block
                        w-full
                        p-2.5
                      "
                      v-model="comments"
                      placeholder="Rédigez un commentaire à propos du temps de travail que vous venez d'achever.."
                    />
                  </div>
                </form>
              </div>

              <div class="mt-8 flex justify-end">
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
import { defineComponent, ref } from "vue";
import { formatTime } from "@/utils/date";
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
// Store import
import { workingTimeStore } from "@/store/workingtime";
import { WorkingTime } from "@/types/global";
import { apiServer } from "../../api/apiServer";

export default defineComponent({
  props: {
    isOpen: Boolean,
    breakingTime: Number,
    workingTime: Number,
    startedAt: Date,
    endedAt: Date,
  },
  components: {
    // Modal
    TransitionRoot,
    TransitionChild,
    Dialog,
    DialogOverlay,
    DialogTitle,
  },
  setup(props, { emit }) {
    const toast = useToast();

    const comments = ref<string>("");
    const taskName = ref<string>("");

    const closeModal = () => {
      emit("close:modal");
    };

    const sendCreateForm = () => {
      const isValidWorkingTime = taskName.value ? true : false;
      const isValidStartedDate = props.startedAt ? true : false;
      const isValidEndeddDate = props.endedAt ? true : false;

      const isFormUnvalid = [
        isValidWorkingTime,
        isValidStartedDate,
        isValidEndeddDate,
      ].includes(false);

      if (!isFormUnvalid) {
        const workingTime: WorkingTime = {
          name: taskName.value as string,
          start: props.startedAt?.toISOString() as string,
          end: props.endedAt?.toISOString() as string,
          pause: props.breakingTime as number,
          comment: comments.value,
        };
        // made it inside the api call
        const queryParams: WorkingTime = {
          name: workingTime.name,
          start: workingTime.start,
          end: workingTime.end,
          pause: workingTime.pause,
          comment: workingTime.comment,
        };

        apiServer.workingTime
          .current_createWorkingtime(queryParams)
          .then((workingTime) => {
            workingTimeStore.createOne(workingTime);
            workingTimeStore.fetchAllWorkingTimes();
          })
          .catch(() => {
            toast.error(
              "Oops.. il semblerait que l'on est rencontré un soucis"
            );
          });

        toast.success("Votre temps de travail a été sauvegardé avec succès");
        emit("created:workingTime");
        closeModal();
      } else {
        toast.error("Les informations du formulaire sont incorrectes");
      }
    };
    return {
      taskName,
      comments,
      formatTime,
      closeModal,
      sendCreateForm,
    };
  },
});
</script>
