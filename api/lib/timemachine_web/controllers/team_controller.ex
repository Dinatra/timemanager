defmodule TimemachineWeb.TeamController do
  use TimemachineWeb, :controller

  alias Timemachine.TeamManager
  alias Timemachine.TeamManager.Team

  action_fallback TimemachineWeb.FallbackController

  def current_teams_me(conn, _) do
    user = Guardian.Plug.current_resource(conn)
    teams = TeamManager.getTeamsOfUser(user.id)

    IO.inspect(teams)

    conn
    |> put_status(200)
    |> render("list.json", teams: teams)
  end

  def leave_team_me(conn, %{"teamID" => teamID}) do
    user = Guardian.Plug.current_resource(conn)
    {parsed_id, _} = Integer.parse(teamID)

    target = TeamManager.getTeam(user.id, parsed_id)

    if !target do
      conn
      |> send_resp(400, "Team not found.")
    else
      TeamManager.leave(target)

      conn
      |> put_status(200)
      |> render("team.json", team: target)
    end
  end

  def delete(conn, %{"teamID" => teamID}) do
    user = Guardian.Plug.current_resource(conn)
    {parsed_id, _} = Integer.parse(teamID)

    target = TeamManager.getTeam(user.id, parsed_id)

    if target.is_owner == false do
      conn
      |> send_resp(403, "You are not owner of this team")
    else
      with {:ok, %Team{}} <- TeamManager.delete_team(target.team) do
        send_resp(conn, 200, "Success")
      end
    end
  end

  def create(conn, %{"team" => %{"name" => name}}) do
    user = Guardian.Plug.current_resource(conn)

    team_params = %{
      name: name
    }

    with {:ok, %Team{} = team} <- TeamManager.create_team(team_params),
         {:ok, _} <- TeamManager.addUserInTeam(user.id, team.id, true) do
      conn
      |> put_status(:created)
      |> render("team_.json", team: team)
    end
  end

  def get_team_member(conn, %{"teamID" => teamID}) do
    user = Guardian.Plug.current_resource(conn)

    {team_id, _} = Integer.parse(teamID)

    target = TeamManager.getTeam(user.id, team_id)

    if !target do
      conn
      |> send_resp(400, "Team not found.")
    else
      users = TeamManager.getUserTeam(team_id)
      conn
      |> put_status(200)
      |> put_view(TimemachineWeb.UserView)
      |> render("index.json", users: users)
    end
  end

  def add_remove_user(conn, %{"teamID" => teamID, "userID" => userID, "invite" => invite}) do
    user = Guardian.Plug.current_resource(conn)

    {team_id, _} = Integer.parse(teamID)
    {user_id, _} = Integer.parse(userID)

    target = TeamManager.getTeam(user.id, team_id)

    if !target && invite == false do
      conn
      |> send_resp(400, "Team not found.")
    else
      if invite == true do
        TeamManager.addUserInTeam(user_id, team_id, false)
      else
        TeamManager.removeUserInTeam(target)
      end

      conn |> send_resp(200, "OK.")
    end
  end
end
