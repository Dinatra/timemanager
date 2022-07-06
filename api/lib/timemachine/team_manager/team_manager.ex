defmodule Timemachine.TeamManager do
  import Ecto.Query, warn: false
  alias Timemachine.Repo

  alias Timemachine.TeamManager.Team
  alias Timemachine.UserManager.User
  alias Timemachine.TeamManager.UserTeam

  def get(teamID) do
    Repo.get!(Team, teamID)
  end

  def getTeamsOfUser(userID) do
    Repo.all(
      from(ut in Timemachine.TeamManager.UserTeam,
        where: ut.user_id == ^userID
      )
    )
    |> Repo.preload([:team])
  end

  def getTeam(userID, teamID) do
    Repo.one(
      from(ut in Timemachine.TeamManager.UserTeam,
        where: ut.user_id == ^userID and ut.team_id == ^teamID
      )
    )
    |> Repo.preload([:team])
  end

  def addUserInTeam(userID, teamId, owner) do
    %UserTeam{}
    |> UserTeam.changeset(%{
      user_id: userID,
      team_id: teamId,
      is_owner: owner
    })
    |> Repo.insert()
  end

  def removeUserInTeam(%UserTeam{} = userteam), do: Repo.delete(userteam)

  def leave(%Timemachine.TeamManager.UserTeam{} = userTeam), do: Repo.delete(userTeam)

  def create_team(attrs \\ %{}) do
    %Team{}
    |> Team.changeset(attrs)
    |> Repo.insert()
  end

  def getUserTeam(teamID) do
    query =
      from ut in UserTeam,
        join: u in User,
        on: ut.user_id == u.id,
        where: ut.team_id == ^teamID

    query =
      from [ut, u] in query,
        select: u

    Repo.all(query)
  end

  def delete_team(%Team{} = team) do
    Repo.delete(team)
  end
end
