import { Team } from "@/types/global";
import { Store } from "./main";

import { apiServer } from "@/api/apiServer";
interface Teams extends Record<string, unknown> {
  teams: Array<Team>;
}

class TeamStore extends Store<Teams> {
  protected data(): Teams {
    return {
      teams: [],
    };
  }

  fetchAllTeams() {
    apiServer.teams.current_getUserTeams().then((data) => {
      console.log(data);
      this.state.teams = data.data;
    });

    console.log(this.state.teams);
  }

  createTeam(team: Team) {
    const example_team: Team = {
      ...team,
    };

    this.state.teams.push(example_team);
  }

  deleteById(id: string) {
    console.log("Im called with id :", id);
    this.state.teams = this.state.teams.filter((team: Team) => {
      return team.id != id;
    });
  }
}

export const teamStore: TeamStore = new TeamStore();
