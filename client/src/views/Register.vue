<!-- eslint-disable max-len -->

<template>
  <section
    class="
      flex
      md:flex-wrap
      content-center
      md:py-20 md:bg-gray-100
      overflow-x-hidden
      h-screen
    "
  >
    <div class="relative container px-4 mx-auto">
      <div class="md:shadow-2xl relative md:max-w-lg md:mx-auto">
        <div class="relative p-4 md:px-10 md:py-10 bg-white">
          <div class="mx-auto text-center">
            <h3
              class="
                pb-4
                text-4xl
                font-bold font-heading
                border-b border-gray-100
                text-blue-700
                md:text-3xl
              "
            >
              Inscrivez-vous
            </h3>
            <router-link class="p-4 inline-block text-blue-500 mb-10" to="/"
              >Déjà inscrit ? Connectez vous</router-link
            >
            <form class="flex flex-col" @submit.prevent="sendForm">
              <input
                class="
                  w-full
                  mb-4
                  px-6
                  py-4
                  border border-gray-200
                  rounded-md
                  focus:ring-blue-300 focus:border-blue-300
                "
                type="text"
                placeholder="steven@example.dev"
                v-model="email"
              />
              <input
                class="
                  w-full
                  mb-4
                  px-6
                  py-4
                  border border-gray-200
                  rounded-md
                  focus:ring-blue-300 focus:border-blue-300
                "
                type="text"
                placeholder="Username"
                v-model="username"
              />
              <input
                class="
                  w-full
                  mb-4
                  px-6
                  py-4
                  border border-gray-200
                  rounded-md
                  focus:ring-blue-300 focus:border-blue-300
                "
                type="password"
                placeholder="Password"
                v-model="password"
              />
              <input
                class="
                  w-full
                  mb-10
                  px-6
                  py-4
                  border border-gray-200
                  rounded-md
                  focus:ring-blue-300 focus:border-blue-300
                "
                type="password"
                placeholder="Repeat password"
                v-model="confirmPassword"
              />
              <button
                class="
                  ml-auto
                  mt-6
                  bg-blue-800
                  text-white
                  font-bold font-heading
                  py-4
                  px-4
                  rounded-md
                  uppercase
                  md:mt-6
                  hover:bg-blue-900
                  w-1/2
                "
              >
                Inscription
              </button>
            </form>
          </div>
        </div>
      </div>
    </div>
  </section>
</template>

<script lang="ts">
import { defineComponent, reactive, toRefs } from "vue";
// toaster import
import { useToast } from "vue-toastification";
// api
import { apiServer } from "@/api/apiServer";
// import vue router
import { useRouter } from "vue-router";

export default defineComponent({
  setup(_, { emit }) {
    const toast = useToast();

    const closeModal = () => {
      emit("close:modal");
    };

    const formData = reactive({
      username: "",
      email: "",
      password: "",
      confirmPassword: "",
    });

    const router = useRouter();

    const sendForm = () => {
      const isUsernameValid = formData.username.length > 0;
      const isEmailValid = formData.email.length > 0;
      const isPasswordValid = formData.password.length > 8;
      const isPasswordEqual = formData.password === formData.confirmPassword;

      const isFormUnvalid = [
        isUsernameValid,
        isEmailValid,
        isPasswordValid,
        isPasswordEqual,
      ].includes(false);

      if (!isFormUnvalid) {
        const [username, password, email] = [
          formData.username,
          formData.password,
          formData.email,
        ];

        apiServer.auth
          .register(username, password, email)
          .then(() => {
            router.push("/login");
            toast.success("Inscription réussie");
          })
          .catch((e) => {
            console.log(e);
            toast.error(
              "Une erreur s'est produite, veuillez réessayer ultérieurement: "
            );
          });
      } else {
        toast.error("Les informations du formulaire sont incorrectes");
      }
    };
    return {
      closeModal,
      sendForm,
      ...toRefs(formData),
    };
  },
});
</script>
