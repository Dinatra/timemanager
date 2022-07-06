import { AxiosInstance, AxiosResponse } from "axios";

export default class ClockApi {
  instance: AxiosInstance;

  constructor(instance: AxiosInstance) {
    this.instance = instance;
  }

  async getCurrentUserClock() {
    return this.instance
      .post("/api/clocks", {})
      .then((res: AxiosResponse<{ data: Clock }>) => res.data);
  }

  async addCurrentUserClock(status: boolean) {
    return this.instance
      .post("/api/clocks", {})
      .then((res: AxiosResponse<{ data: Clock }>) => res.data);
  }
}

/*
 * Types
 */

type Clock = {
  id: number;
  status: boolean;
  time: string;
};

export { Clock };
