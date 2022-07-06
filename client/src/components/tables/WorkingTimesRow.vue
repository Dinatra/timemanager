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
      {{ data.name }}
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
      {{ formatDate(data.start) }}
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
      {{ formatDate(data.end) }}
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
        <span class="mr-2">{{ convertDifferenceInPercentage() }}%</span>
        <div class="relative w-full">
          <div class="overflow-hidden h-2 text-xs flex rounded bg-blue-200">
            <div
              :style="'width: ' + convertDifferenceInPercentage() + '%'"
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
                  @click="deleteWorkingTime"
                >
                  <TrashIcon
                    :class="[
                      active ? ' text-white' : 'text-white',
                      'w-5 h-5 mr-2',
                    ]"
                    aria-hidden="true"
                  />
                  Supprimer
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
// utils
import { formatDate } from "@/utils/date";
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
import { WorkingTime } from "@/types/global";

export default defineComponent({
  props: {
    data: {
      type: Object as PropType<WorkingTime>,
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
    const deleteWorkingTime = () => {
      emit("delete:workingTime", props.data.id);
    };

    const convertDifferenceInPercentage = () => {
      const startAt = new Date(props.data.start).getTime();
      const endAt = new Date(props.data.end).getTime();
      // temps de travail :  59000 / 100 = 590
      // temps de pause : 15000

      console.log("temps de travail : ", endAt - startAt);
      const calculatedDifference = Math.floor(
        props.data.pause / ((endAt - startAt) / 100)
      );
      return calculatedDifference;
    };

    return {
      deleteWorkingTime,
      formatDate,
      convertDifferenceInPercentage,
    };
  },
});
</script>
