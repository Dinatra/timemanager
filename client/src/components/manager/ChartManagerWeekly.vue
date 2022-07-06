<template>
  <div id="chart" class="w-full h-full">
    <apexchart
      type="bar"
      height="100%"
      width="100%"
      :options="chartOptions"
      :series="series"
    ></apexchart>
  </div>
</template>

<script lang="ts">
import { defineComponent } from "vue";

export default defineComponent({
  setup() {
    return {
      series: [
        {
          name: "heures de jour",
          data: [6, 6, 6.5, 6.5, 0, 0, 0],
        },
        {
          name: "heures de nuit",
          data: [0, 1, 0.5, 0.5, 0, 0, 0],
        },
        {
          name: "heures supp",
          data: [0, 0, 0.5, 0.5, 0, 0, 0],
        },
      ],

      chartOptions: {
        title: {
          text: "Heures enregistrées cette semaine",
          align: "top",
        },

        chart: {
          type: "bar",
          height: 350,
          stacked: true,
          toolbar: {
            show: true,
          },
          zoom: {
            enabled: true,
          },
        },

        responsive: [
          {
            breakpoint: 480,
            options: {
              legend: {
                position: "bottom",
                offsetX: -10,
                offsetY: 0,
              },
            },
          },
        ],

        plotOptions: {
          bar: {
            horizontal: false,
            borderRadius: 15,
          },
        },

        xaxis: {
          type: "string",
          categories: [
            "Lundi",
            "Mardi",
            "Mercredi",
            "Jeudi",
            "Vendredi",
            "Samedi",
            "Dimanche",
          ],
        },

        legend: {
          position: "right",
          offsetY: 40,
        },
        fill: {
          opacity: 1,
        },
      },
    };
  },
});
</script>
