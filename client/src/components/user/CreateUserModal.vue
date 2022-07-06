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
                Création d'un compte utilisateur
              </DialogTitle>
              <div class="mt-10">
                <form action="">
                  <div class="mb-3">
                    <label
                      for="email"
                      class="text-sm font-medium text-gray-900 block mb-2"
                      >Votre email</label
                    >
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
                      v-model="email"
                      placeholder="name@flowbite.com"
                      required
                    />
                  </div>
                  <div class="mb-3">
                    <label
                      for="username"
                      class="text-sm font-medium text-gray-900 block mb-2"
                      >Votre nom d'utilisateur</label
                    >
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
                      v-model="username"
                      placeholder="Batman"
                      required
                    />
                  </div>
                  <div class="mb-3">
                    <label
                      for="password"
                      class="text-sm font-medium text-gray-900 block mb-2"
                      >Votre mot de passe</label
                    >
                    <input
                      type="password"
                      id="password"
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
                      v-model="password"
                      required
                    />
                  </div>
                  <div class="mb-3">
                    <label
                      for="password"
                      class="text-sm font-medium text-gray-900 block mb-2"
                      >Votre nouveau mot de passe</label
                    >
                    <input
                      type="confirmPassword"
                      id="confirmPassword"
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
                      v-model="confirmPassword"
                      required
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
import { defineComponent, reactive, toRefs } from "vue";
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

export default defineComponent({
  props: {
    isOpen: Boolean,
    userData: Object,
  },
  components: {
    TransitionRoot,
    TransitionChild,
    Dialog,
    DialogOverlay,
    DialogTitle,
  },
  setup(_, { emit }) {
    const toast = useToast();

    const closeModal = () => {
      emit("close:modal");
    };

    const userFormData = reactive({
      username: "",
      email: "",
      password: "",
      confirmPassword: "",
    });

    const sendCreateForm = () => {
      const isUsernameValid = userFormData.username.length > 0;
      const isEmailValid = userFormData.email.length > 0;
      const isPasswordValid = userFormData.password.length > 8;
      const isPasswordEqual =
        userFormData.password === userFormData.confirmPassword;

      const isFormUnvalid = [
        isUsernameValid,
        isEmailValid,
        isPasswordValid,
        isPasswordEqual,
      ].includes(false);

      if (!isFormUnvalid) {
        toast.success("L'utilisateur a été crée avec succès");
      } else {
        toast.error("Les informations du formulaire sont incorrectes");
      }
    };
    return {
      closeModal,
      sendCreateForm,
      ...toRefs(userFormData),
    };
  },
});
</script>
