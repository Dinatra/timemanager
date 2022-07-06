<!-- eslint-disable max-len -->
<template>
  <DashboardLayout>
    <div class="flex flex-row flex-wrap">
      <div class="bg-white shadow overflow-hidden sm:rounded-lg w-full">
        <UserCard />
        <div class="px-4 py-5 sm:px-6">
          <h3 class="text-lg leading-6 font-medium text-gray-900">
            Informations utilisateur
          </h3>
          <p class="mt-1 max-w-2xl text-sm text-gray-500">
            Vos informations personnelles listées ci dessous
          </p>
        </div>
        <div class="border-t border-gray-200">
          <dl>
            <div
              class="
                bg-gray-50
                px-4
                py-5
                sm:grid sm:grid-cols-3 sm:gap-4 sm:px-6
              "
            >
              <dt class="text-sm font-medium text-gray-500">
                Nom d'utilisateur
              </dt>
              <dd class="mt-1 text-sm text-gray-900 sm:mt-0 sm:col-span-2">
                {{ userStoreState.username }}
              </dd>
            </div>
            <div
              class="bg-white px-4 py-5 sm:grid sm:grid-cols-3 sm:gap-4 sm:px-6"
            >
              <dt class="text-sm font-medium text-gray-500">Role</dt>
              <dd class="mt-1 text-sm text-gray-900 sm:mt-0 sm:col-span-2"></dd>
            </div>
            <div
              class="
                bg-gray-50
                px-4
                py-5
                sm:grid sm:grid-cols-3 sm:gap-4 sm:px-6
              "
            >
              <dt class="text-sm font-medium text-gray-500">Adresse email</dt>
              <dd class="mt-1 text-sm text-gray-900 sm:mt-0 sm:col-span-2">
                {{ userStoreState.email }}
              </dd>
            </div>
            <div
              class="bg-white px-4 py-5 sm:grid sm:grid-cols-3 sm:gap-4 sm:px-6"
            >
              <dt class="text-sm font-medium text-gray-500">Mes équipes</dt>
              <dd class="mt-1 text-sm text-gray-900 sm:mt-0 sm:col-span-2">
                <ul
                  role="list"
                  class="
                    border border-gray-200
                    rounded-md
                    divide-y divide-gray-200
                  "
                >
                  <li
                    class="
                      pl-3
                      pr-4
                      py-3
                      flex
                      items-center
                      justify-between
                      text-sm
                    "
                  >
                    <div class="w-0 flex-1 flex items-center">
                      <!-- Heroicon name: solid/paper-clip -->
                      <svg
                        class="flex-shrink-0 h-5 w-5 text-gray-400"
                        xmlns="http://www.w3.org/2000/svg"
                        viewBox="0 0 20 20"
                        fill="currentColor"
                        aria-hidden="true"
                      >
                        <path
                          fill-rule="evenodd"
                          d="M8 4a3 3 0 00-3 3v4a5 5 0 0010 0V7a1 1 0 112 0v4a7 7 0 11-14 0V7a5 5 0 0110 0v4a3 3 0 11-6 0V7a1 1 0 012 0v4a1 1 0 102 0V7a3 3 0 00-3-3z"
                          clip-rule="evenodd"
                        />
                      </svg>
                      <span class="ml-2 flex-1 w-0 truncate">
                        resume_back_end_developer.pdf
                      </span>
                    </div>
                    <div class="ml-4 flex-shrink-0">
                      <a
                        href="#"
                        class="
                          font-medium
                          text-indigo-600
                          hover:text-indigo-500
                        "
                      >
                        Download
                      </a>
                    </div>
                  </li>
                  <li
                    class="
                      pl-3
                      pr-4
                      py-3
                      flex
                      items-center
                      justify-between
                      text-sm
                    "
                  >
                    <div class="w-0 flex-1 flex items-center">
                      <!-- Heroicon name: solid/paper-clip -->
                      <svg
                        class="flex-shrink-0 h-5 w-5 text-gray-400"
                        xmlns="http://www.w3.org/2000/svg"
                        viewBox="0 0 20 20"
                        fill="currentColor"
                        aria-hidden="true"
                      >
                        <path
                          fill-rule="evenodd"
                          d="M8 4a3 3 0 00-3 3v4a5 5 0 0010 0V7a1 1 0 112 0v4a7 7 0 11-14 0V7a5 5 0 0110 0v4a3 3 0 11-6 0V7a1 1 0 012 0v4a1 1 0 102 0V7a3 3 0 00-3-3z"
                          clip-rule="evenodd"
                        />
                      </svg>
                      <span class="ml-2 flex-1 w-0 truncate">
                        coverletter_back_end_developer.pdf
                      </span>
                    </div>
                    <div class="ml-4 flex-shrink-0">
                      <a
                        href="#"
                        class="
                          font-medium
                          text-indigo-600
                          hover:text-indigo-500
                        "
                      >
                        Download
                      </a>
                    </div>
                  </li>
                </ul>
              </dd>
            </div>
          </dl>
        </div>
      </div>
    </div>
  </DashboardLayout>
</template>

<script lang="ts">
import { defineComponent, onMounted } from "vue";
// Import components
import UserCard from "@/components/user/UserCard.vue";
import DashboardLayout from "@/layouts/DashboardLayout.vue";
// Import api
import { apiServer } from "@/api/apiServer";
// import toast
import { useToast } from "vue-toastification";
// import store
import { userStore } from "@/store/user";

export default defineComponent({
  components: {
    UserCard,
    DashboardLayout,
  },

  setup() {
    const toast = useToast();

    onMounted(() => {
      // on component mount => fill the userStore with actual user data
      apiServer.users
        .currentProfil()
        .then((user) => {
          userStore.updateUser(user);
        })
        .catch((e) => {
          toast.error(e.response.data.message);
        });
    });

    return {
      userStoreState: userStore.getState(),
    };
  },
});
</script>
