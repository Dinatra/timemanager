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
              Connectez vous
            </h3>
            <router-link
              class="p-4 inline-block text-blue-500 mb-10"
              to="/register"
              >Pas de compte ? Inscrivez vous</router-link
            >
          </div>
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
              v-model="username"
              type="text"
              placeholder="Username.."
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
              v-model="password"
              type="password"
              placeholder="Password"
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
                text-center
              "
              to="/"
            >
              Connexion
            </button>
          </form>
        </div>
      </div>
    </div>
  </section>
</template>

<script>
import { useToast } from "vue-toastification";
import { defineComponent, reactive, toRefs } from "vue";
// api
import { apiServer } from "@/api/apiServer";
// store
import { userStore } from "@/store/user";
// import vue router
import { useRouter } from "vue-router";

export default defineComponent({
  setup() {
    const toast = useToast();

    const formData = reactive({
      username: "",
      password: "",
    });

    const router = useRouter();

    const sendForm = () => {
      const isUsernameValid = formData.username.length > 0;
      const isPasswordValid = formData.password.length > 8;
      const isFormUnvalid = [isUsernameValid, isPasswordValid].includes(false);
      console.log(router);

      if (!isFormUnvalid) {
        const [username, password] = [formData.username, formData.password];

        apiServer.auth
          .login(username, password)
          .then((data) => {
            userStore.login(data.user, data.csrf_token);
            router.push("/");
            toast.success("Connexion succesfull");
          })
          .catch((e) => {
            toast.error(
              "Une erreur s'est produite, veuillez réessayer ultérieurement"
            );
            console.log(e);
          });
      } else {
        toast.error(
          "Les informations du formulaire de connexion sont incorrectes"
        );
      }
    };

    return {
      sendForm,
      ...toRefs(formData),
    };
  },
});
</script>
