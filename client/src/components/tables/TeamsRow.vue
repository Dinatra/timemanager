<template>
  <tr>
    <th
      class="
        border-t-0
        px-6
        align-middle
        text-xs
        whitespace-nowrap
        font-normal
        p-4
        text-left
      "
    >
      {{ team.name }}
    </th>
    <td
      class="
        border-t-0
        px-6
        align-middle
        border-l-0 border-r-0
        text-xs
        whitespace-nowrap
        p-4
      "
    >
      <!-- {{ team.tasks.length }} -->
    </td>
    <td
      class="
        border-t-0
        px-6
        align-middle
        border-l-0 border-r-0
        text-xs
        whitespace-nowrap
        p-4
      "
    >
      <!-- {{ team.users.length }} -->
    </td>
    <td
      class="
        border-t-0
        px-6
        align-middle
        border-l-0 border-r-0
        text-xs
        whitespace-nowrap
        p-4
      "
    >
      <!-- {{ team.owner }} -->
    </td>
    <td
      class="
        border-t-0
        px-6
        align-middle
        border-l-0 border-r-0
        text-xs
        whitespace-nowrap
        p-4
      "
    >
      <div class="flex items-center">
        <span class="mr-2">? %</span>
        <div class="relative w-full">
          <div class="overflow-hidden h-2 text-xs flex rounded bg-blue-200">
            <div
              :style="
                'width: ' + Math.floor(Math.random() * (100 - 0 + 1) + 0) + '%'
              "
              class="
                shadow-none
                flex flex-col
                text-center
                whitespace-nowrap
                text-white
                justify-center
                bg-blue-400
              "
            ></div>
          </div>
        </div>
      </div>
    </td>
    <td
      class="
        border-t-0
        px-6
        align-middle
        border-l-0 border-r-0
        text-xs
        whitespace-nowrap
        p-4
        text-right
      "
    >
      <Menu as="div" class="relative inline-block text-left">
        <div>
          <MenuButton class="p-2">
            <DotsHorizontalIcon
              class="w-5 h-5 ml-2 text-blue-800 cursor-pointer"
            />
          </MenuButton>
        </div>

        <transition
          enter-active-class="transition duration-100 ease-out"
          enter-from-class="transform scale-95 opacity-0"
          enter-to-class="transform scale-100 opacity-100"
          leave-active-class="transition duration-75 ease-in"
          leave-from-class="transform scale-100 opacity-100"
          leave-to-class="transform scale-95 opacity-0"
        >
          <MenuItems
            class="
              absolute
              right-0
              w-56
              mt-2
              z-10
              origin-top-right
              bg-white
              divide-y divide-gray-100
              rounded-md
              shadow-lg
              ring-1 ring-black ring-opacity-5
              focus:outline-none
            "
          >
            <div class="px-1 py-1">
              <MenuItem v-slot="{ active }">
                <button
                  :class="[
                    active ? 'bg-blue-400 text-white' : 'text-gray-900',
                    'group flex rounded-md items-center w-full px-2 py-2 text-sm',
                  ]"
                >
                  <EyeIcon
                    :active="active"
                    :class="[
                      active ? ' text-white' : 'text-blue-500',
                      'w-5 h-5 mr-2 text-black',
                    ]"
                    aria-hidden="true"
                  />
                  Visualiser
                </button>
              </MenuItem>
              <MenuItem v-slot="{ active }">
                <button
                  :class="[
                    active ? 'bg-blue-400 text-white' : 'text-gray-900',
                    'group flex rounded-md items-center w-full px-2 py-2 text-sm',
                  ]"
                >
                  <PencilIcon
                    :active="active"
                    :class="[
                      active ? ' text-white' : 'text-blue-500',
                      'w-5 h-5 mr-2 text-black',
                    ]"
                    aria-hidden="true"
                  />
                  Mettre à jour
                </button>
              </MenuItem>
              <MenuItem v-slot="{ active }">
                <button
                  class="
                    'group
                    flex
                    rounded-md
                    items-center
                    w-full
                    px-2
                    py-2
                    text-sm
                    bg-red-500
                    text-white
                    mt-1
                  "
                  @click="deleteTeam"
                >
                  <TrashIcon
                    :class="[
                      active ? ' text-white' : 'text-white',
                      'w-5 h-5 mr-2',
                    ]"
                    aria-hidden="true"
                  />
                  Quitter
                </button>
              </MenuItem>
            </div>
          </MenuItems>
        </transition>
      </Menu>
    </td>
  </tr>
</template>

<script lang="ts">
import { defineComponent, PropType } from "vue";
//  Heroicon
import {
  DotsHorizontalIcon,
  PencilIcon,
  TrashIcon,
  EyeIcon,
} from "@heroicons/vue/solid";
// Headless UI
import { Menu, MenuButton, MenuItems, MenuItem } from "@headlessui/vue";
// Store
import { Team } from "@/types/global";

export default defineComponent({
  props: {
    team: {
      type: Object as PropType<Team>,
      required: true,
    },
  },

  components: {
    DotsHorizontalIcon,
    PencilIcon,
    EyeIcon,
    TrashIcon,
    Menu,
    MenuButton,
    MenuItems,
    MenuItem,
  },

  setup(props, { emit }) {
    const deleteTeam = () => {
      emit("delete:team", props.team.id);
    };

    return {
      deleteTeam,
    };
  },
});
</script>
