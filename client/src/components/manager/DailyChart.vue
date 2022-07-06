<template>
  <div id="chart" class="w-full h-full">
    <apexchart
      type="donut"
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
      series: [6.5, 0.5, 0.5],

      chartOptions: {
        title: {
          text: "Heures enregistrées ce jour",
          align: "top",
        },

        legend: {
          show: true,
          position: "right",
          offsetX: 0,
          offsetY: 75,
        },

        labels: ["heures de jour", "heures de nuit", "heures supp"],

        chart: {
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

        // Total Hours work this day in center of the chart
        plotOptions: {
          pie: {
            donut: {
              labels: {
                show: true,
                name: {
                  show: true,
                },

                value: {
                  show: true,
                  formatter(s: string) {
                    return `${s} heures`;
                  }
                },

                total: {
                  show: true,
                  label: "Total ",
                  formatter(w: any) {
                    return (
                      w.globals.seriesTotals.reduce(
                        (s1: string, s2: string) => {
                          return s1 + s2;
                        },
                        0
                      ) + " heures"
                    );
                  },
                },
              },
            },
          },
        },
      },
    };
  },
});
</script>
