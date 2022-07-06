import { AxiosInstance, AxiosResponse } from "axios";
import { Team } from "@/types/global";
export default class TeamApi {
  instance: AxiosInstance;

  constructor(instance: AxiosInstance) {
    this.instance = instance;
  }

  async current_getUserTeams() {
    return this.instance
      .get("/api/teams")
      .then((res: AxiosResponse<{ data: Team[] }>) => res.data);
  }

  async current_leaveUserTeam(id: string) {
    return this.instance
      .post(`/api/teams/${id}/leave`)
      .then((res: AxiosResponse<Team>) => res.data);
  }

  async createNewTeam(team: Team) {
    return this.instance
      .post(`/api/teams`, {
        team: {
          name: team.name,
        },
      })
      .then((res: AxiosResponse<Team>) => res.data);
  }
}
