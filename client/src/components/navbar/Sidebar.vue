<!-- eslint-disable max-len -->

<template>
  <div class="hidden lg:block navbar-menu relative z-50">
    <nav
      class="
        fixed
        top-0
        left-0
        bottom-0
        flex flex-col
        w-3/4
        pt-6
        bg-red
        border-r
        overflow-y-auto
        lg:w-80
        sm:max-w-xs
      "
    >
      <div
        class="
          flex
          w-full
          items-center
          px-6
          pb-6
          mb-6
          border-blue-50
          lg:border-b
        "
      >
        <a class="text-xl h-16 w-full" href="#">
          <img
            class="h-full w-full object-contain mx-auto"
            src="https://upload.wikimedia.org/wikipedia/commons/2/2d/Epitech.png"
            alt=""
            width="auto"
          />
        </a>
      </div>
      <div class="px-4 pb-6">
        <ul class="mb-8 text-sm font-medium">
          <!-- Dashbord -->
          <li>
            <router-link
              class="
                flex
                items-center
                pl-3
                py-3
                pr-4
                text-gray-500
                rounded
                navbar-items
              "
              to="/"
            >
              <span class="inline-block mr-3">
                <MonitorIcon class="w-6 h-6 cursor-pointer" />
              </span>
              <span>Dashboard</span></router-link
            >
          </li>

          <!-- Tasks -->
          <li>
            <router-link
              class="
                flex
                items-center
                pl-3
                py-3
                pr-4
                text-gray-500
                rounded
                navbar-items
              "
              to="/tasks"
            >
              <span class="inline-block mr-3">
                <BadgeCheckIcon class="w-6 h-6 cursor-pointer" />
              </span>
              <span>Tâches</span></router-link
            >
          </li>

          <!-- Workingtimes -->
          <li>
            <router-link
              class="
                flex
                items-center
                pl-3
                py-3
                pr-2
                text-gray-500
                hover:bg-blue-50
                rounded
                navbar-items
              "
              to="/workingtimes"
            >
              <span class="inline-block mr-3">
                <ClockIcon class="w-6 h-6 cursor-pointer" />
              </span>
              <span>Mes temps de travail</span></router-link
            >
          </li>

          <!-- Teams -->
          <li>
            <router-link
              class="
                flex
                items-center
                pl-3
                py-3
                pr-4
                text-gray-500
                rounded
                navbar-items
              "
              to="/teams"
            >
              <span class="inline-block mr-3">
                <UserGroupIcon class="w-6 h-6 cursor-pointer" />
              </span>
              <span>Équipes</span></router-link
            >
          </li>

          <!-- User -->
          <li>
            <router-link
              class="
                flex
                items-center
                pl-3
                py-3
                pr-4
                text-gray-500
                rounded
                navbar-items
              "
              to="/User"
            >
              <span class="inline-block mr-3">
                <UserIcon class="w-6 h-6 cursor-pointer" />
              </span>
              <span>Compte & parametres</span></router-link
            >
          </li>

          <!-- help -->
          <li>
            <a
              class="
                flex
                items-center
                pl-3
                py-3
                pr-4
                text-gray-500
                rounded
                navbar-items
              "
              href="https://www.notion.so/Time-manager-08a4c85f54254a2ba4f017cfad585b5f"
              target="_blank"
            >
              <span class="inline-block mr-3">
                <QuestionMarkCircleIcon class="w-6 h-6 cursor-pointer" />
              </span>
              <span>Documentations</span></a
            >
          </li>
        </ul>
      </div>

      <!-- logout -->
      <a
        class="
          text-xs
          uppercase
          text-gray-500
          font-medium
          fixed
          flex
          align-center
          items-center
          bottom-0
          px-8
          pb-4
          w-80
          hover:bg-blue-50
          rounded
        "
        href="#/login"
      >
        <span class="inline-block mr-3 text-gray-500">
          <LogoutIcon class="w-6 h-6 cursor-pointer" />
        </span>
        <span>Déconnexion</span>
      </a>
    </nav>
  </div>
</template>

<script lang="ts">
import { defineComponent } from "vue";
import MonitorIcon from "@/components/svg/MonitorIcon.vue";
import {
  UserIcon,
  ClockIcon,
  LogoutIcon,
  UserGroupIcon,
  BadgeCheckIcon,
  QuestionMarkCircleIcon,
} from "@heroicons/vue/solid";

export default defineComponent({
  components: {
    // Heroicons
    MonitorIcon,
    UserIcon,
    ClockIcon,
    LogoutIcon,
    UserGroupIcon,
    BadgeCheckIcon,
    QuestionMarkCircleIcon,
  },
});
</script>
