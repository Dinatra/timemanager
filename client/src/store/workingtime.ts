import { WorkingTime } from "@/types/global";
import { apiServer } from "@/api/apiServer";
import { Store } from "./main";
import { useToast } from "vue-toastification";

interface WorkingTimes extends Record<string, unknown> {
  workingTimes: Array<WorkingTime>;
}

class WorkingTimeStore extends Store<WorkingTimes> {
  protected data(): WorkingTimes {
    return {
      workingTimes: [],
    };
  }

  deleteById(id: string) {
    this.state.workingTimes = this.state.workingTimes.filter(
      (WorkingTime: WorkingTime) => {
        return WorkingTime.id != id;
      }
    );
  }

  createOne(workingTime: WorkingTime) {
    this.state.workingTimes.push(workingTime);
  }

  fetchAllWorkingTimes() {
    const start = "2021-10-23T13:53:28";
    const end = "2100-10-23T13:53:28";
    const toast = useToast();

    apiServer.workingTime
      .current_getWorkingtimes(start, end)
      .then(({ data }) => {
        this.state.workingTimes = data;
      })
      .catch(() => {
        toast.error("Une erreur s'est produite.. vous avez été redirigé");
      });
  }
}

export const workingTimeStore: WorkingTimeStore = new WorkingTimeStore();
