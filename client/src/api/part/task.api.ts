import { AxiosInstance, AxiosResponse } from "axios";

export default class TeamApi {
  instance: AxiosInstance;

  constructor(instance: AxiosInstance) {
    this.instance = instance;
  }

  async current_getTaskOfTeam(teamID: number) {
    return this.instance
      .get(`/api/tasks/team/${teamID}`)
      .then((res: AxiosResponse<{ data: Team[] }>) => res.data);
  }
}

/*
 * Types
 */

type Team = {
  id: number;
  name: string;
};

export { Team };
