import { AxiosInstance, AxiosResponse } from "axios";
import { WorkingTime } from "../../types/global";
export default class WorkingtimeApi {
  instance: AxiosInstance;

  constructor(instance: AxiosInstance) {
    this.instance = instance;
  }

  async current_getWorkingtimes(start: string, end: string) {
    return this.instance
      .get(`/api/workingtimes?start=${start}&end=${end}`)
      .then((res: AxiosResponse<{ data: WorkingTime[] }>) => res.data);
  }

  async current_createWorkingtime(workingtime: WorkingTime) {
    return this.instance
      .post(`/api/workingtimes`, { workingtime })
      .then((res: AxiosResponse<WorkingTime>) => res.data);
  }
}
