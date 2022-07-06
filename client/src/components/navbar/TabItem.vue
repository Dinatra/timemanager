<template>
  <router-link
    class="
      p-2
      flex flex-wrap
      content-center
      px-4
      h-2/3
      text-blue-200
      mobile-item
    "
    :to="href"
  >
    <slot></slot>
  </router-link>
</template>

<script lang="ts">
export default {
  props: {
    href: {
      type: String,
      required: true,
    },
    isActive: Boolean,
  },
};
</script>
