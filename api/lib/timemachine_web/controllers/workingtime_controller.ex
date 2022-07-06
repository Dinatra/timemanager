defmodule TimemachineWeb.WorkingtimeController do
  use TimemachineWeb, :controller

  alias Timemachine.WorkingtimeManager
  alias Timemachine.TeamManager
  alias Timemachine.WorkingtimeManager.Workingtime

  action_fallback TimemachineWeb.FallbackController

  def search_me(conn, params) do
    startSearch = Map.get(params, "start", "")
    endSearch = Map.get(params, "end", "")

    user = Guardian.Plug.current_resource(conn)

    render(conn, "index.json",
      workingtimes: WorkingtimeManager.search_workingtime(user.id, startSearch, endSearch)
    )
  end

  def post_time(conn,  %{"workingtime" => workingtime_params}) do
    user = Guardian.Plug.current_resource(conn)

    with {:ok, %Workingtime{} = workingtime} <-
           WorkingtimeManager.create_user_workingtime(workingtime_params, user.id) do
      conn
      |> put_status(:created)
      |> render("show.json", workingtime: workingtime)
    end
  end

  def get_all_workingtime_of_team(conn, %{"teamID" => teamID}) do
    user = Guardian.Plug.current_resource(conn)
    {parsed_id, _} = Integer.parse(teamID)

    target = TeamManager.getTeam(user.id, parsed_id)

    if !target do
      conn
      |> send_resp(400, "Team not found.")
    else
      #
      render(
        conn,
        "index.json",
        workingtimes: WorkingtimeManager.get_all_workingtime_of_user_of_team(parsed_id)
      )
    end
  end

  def get_all_workingtime_of_team_specif_user(conn, %{"teamID" => teamID, "userID" => userID}) do
    user = Guardian.Plug.current_resource(conn)
    {parsed_id, _} = Integer.parse(teamID)
    {parsed_user_id, _} = Integer.parse(userID)

    target = TeamManager.getTeam(user.id, parsed_id)

    if !target do
      conn
      |> send_resp(400, "Team not found.")
    else
      #
      render(
        conn,
        "index.json",
        workingtimes: WorkingtimeManager.get_all_workingtime_of_user_of_team_user(parsed_id, parsed_user_id)
      )
    end
  end

  # Old

  def createUserWorktime(conn, %{"userID" => id, "workingtime" => workingtime_params}) do
    {parsed_id, _} = Integer.parse(id)

    with {:ok, %Workingtime{} = workingtime} <-
           WorkingtimeManager.create_user_workingtime(workingtime_params, parsed_id) do
      conn
      |> put_status(:created)
      # |> put_resp_header("location", Routes.workingtime_path(conn, :show, workingtime))
      |> render("show.json", workingtime: workingtime)
    end
  end

  def search(conn, %{"id" => id} = params) do
    startSearch = Map.get(params, "start", "")
    endSearch = Map.get(params, "end", "")
    {parsed_id, _} = Integer.parse(id)

    cond do
      startSearch != "" && endSearch != "" ->
        render(conn, "index.json",
          workingtimes: WorkingtimeManager.search_workingtime(parsed_id, startSearch, endSearch)
        )

      true ->
        render(conn, "show.json", workingtime: WorkingtimeManager.get_workingtime!(id))
    end
  end

  def update(conn, %{"id" => id, "workingtime" => workingtime_params}) do
    workingtime = WorkingtimeManager.get_workingtime!(id)

    with {:ok, %Workingtime{} = workingtime} <-
           WorkingtimeManager.update_workingtime(workingtime, workingtime_params) do
      render(conn, "show.json", workingtime: workingtime)
    end
  end

  def delete(conn, %{"id" => id}) do
    workingtime = WorkingtimeManager.get_workingtime!(id)

    with {:ok, %Workingtime{}} <- WorkingtimeManager.delete_workingtime(workingtime) do
      send_resp(conn, :no_content, "")
    end
  end
end
