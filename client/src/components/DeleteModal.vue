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
                {{ title }}
              </DialogTitle>
              <div class="mt-2">
                <p class="text-sm text-gray-500">
                  Attention, cette action a des conséquences irréversibles.
                </p>
              </div>

              <div class="mt-4 flex justify-end">
                <button
                  type="button"
                  class="
                    inline-flex
                    justify-center
                    px-4
                    py-2
                    text-sm
                    font-medium
                    text-gray-900
                    bg-gray-100
                    border border-transparent
                    rounded-md
                    hover:bg-gray-200
                    focus:outline-none
                    focus-visible:ring-2
                    focus-visible:ring-offset-2
                    focus-visible:ring-gray-500
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
                    text-red-900
                    bg-red-100
                    border border-transparent
                    rounded-md
                    hover:bg-red-200
                    focus:outline-none
                    focus-visible:ring-2
                    focus-visible:ring-offset-2
                    focus-visible:ring-red-500
                  "
                  @click="deleteWorkingTime"
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
import { defineComponent } from "vue";
// Headless UI import
import {
  TransitionRoot,
  TransitionChild,
  Dialog,
  DialogOverlay,
  DialogTitle,
} from "@headlessui/vue";
// Toast import
import { useToast } from "vue-toastification";

export default defineComponent({
  props: {
    isOpen: Boolean,
    title: String,
    successDeleteMessage: String,
  },
  components: {
    TransitionRoot,
    TransitionChild,
    Dialog,
    DialogOverlay,
    DialogTitle,
  },
  setup(props, { emit }) {
    const toast = useToast();

    const closeModal = () => {
      emit("close:modal");
    };

    const deleteWorkingTime = () => {
      toast.success(props.successDeleteMessage as string);
      emit("delete:success");
      emit("close:modal");
    };

    return {
      closeModal,
      deleteWorkingTime,
    };
  },
});
</script>
