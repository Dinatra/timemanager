<template>
  <div
    class="
      fixed
      h-16
      bottom-0
      w-full
      z-50
      bg-white
      shadow-xl
      flex flex-wrap
      items-center
    "
  >
    <Tab>
      <TabItem href="/">
        <MonitorIcon class="w-6 h-6 cursor-pointer" />
      </TabItem>
      <TabItem href="/tasks">
        <BadgeCheckIcon class="w-6 h-6 cursor-pointer" />
      </TabItem>
      <TabItem href="/workingtimes">
        <ClockIcon class="w-6 h-6 cursor-pointer" />
      </TabItem>
      <TabItem href="/teams">
        <UserGroupIcon class="w-6 h-6 cursor-pointer" />
      </TabItem>
      <TabItem href="/user">
        <UserIcon class="w-6 h-6 cursor-pointer" />
      </TabItem>
      <a
        class="
          p-2
          flex flex-wrap
          content-center
          px-4
          h-2/3
          text-blue-200
          mobile-item
        "
        target="_blank"
        href="https://immediate-daffodil-3bf.notion.site/Time-manager-08a4c85f54254a2ba4f017cfad585b5f"
      >
        <QuestionMarkCircleIcon class="w-6 h-6 cursor-pointer" />
      </a>
    </Tab>
  </div>
</template>

<script lang="ts">
import Tab from "./Tab.vue";
import TabItem from "./TabItem.vue";
import MonitorIcon from "@/components/svg/MonitorIcon.vue";
import {
  UserIcon,
  ClockIcon,
  UserGroupIcon,
  BadgeCheckIcon,
  QuestionMarkCircleIcon,
} from "@heroicons/vue/solid";

export default {
  props: ["recipes"],
  components: {
    Tab,
    TabItem,
    // Heroicons
    MonitorIcon,
    UserIcon,
    ClockIcon,
    UserGroupIcon,
    BadgeCheckIcon,
    QuestionMarkCircleIcon,
  },
};
</script>
