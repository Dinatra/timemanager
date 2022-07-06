import { createRouter, createWebHashHistory, RouteRecordRaw } from "vue-router";
// user store import
import { userStore } from "@/store/user";
import Login from "@/views/Login.vue";
import Register from "@/views/Register.vue";
import Dashboard from "@/views/Dashboard.vue";
import UserSetings from "@/views/UserSetings.vue";
import Workingtimes from "@/views/Workingtimes.vue";
import Teams from "@/views/Teams.vue";

const routes: Array<RouteRecordRaw> = [
  {
    path: "/login",
    name: "Login",
    component: Login,
  },
  {
    path: "/register",
    name: "Register",
    component: Register,
  },
  {
    path: "/workingtimes",
    name: "Workingtimes",
    component: Workingtimes,
  },
  {
    path: "/",
    name: "Dashboard",
    component: Dashboard,
  },
  {
    path: "/tasks",
    name: "Tasks",
    component: Dashboard,
  },
  {
    path: "/teams",
    name: "Teams",
    component: Teams,
  },
  {
    path: "/user",
    name: "User",
    component: UserSetings,
  },
];

const router = createRouter({
  history: createWebHashHistory(),
  routes,
});

router.beforeEach((to, from, next) => {
  const isLogged = userStore.getState().username ? true : false;

  const protectedRoute: any = [
    "Workingtimes",
    "Dashboard",
    "Tasks",
    "Teams",
    "User",
  ];

  const offlineRoute: any = ["Login", "Register"];
  const routeName = to.name;

  if (offlineRoute.includes(routeName) && !isLogged) next();
  else if (protectedRoute.includes(routeName) && isLogged) next();
  else if (offlineRoute.includes(routeName) && isLogged) {
    next("/");
  } else {
    next("/login");
  }
});
export default router;
