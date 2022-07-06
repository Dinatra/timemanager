defmodule TimemachineWeb.TaskController do
  use TimemachineWeb, :controller

  alias Timemachine.TeamManager
  alias Timemachine.TaskManager

  action_fallback TimemachineWeb.FallbackController

  def task_of_team(conn, %{"teamID" => teamID}) do
    user = Guardian.Plug.current_resource(conn)
    {parsed_id, _} = Integer.parse(teamID)

    target = TeamManager.getTeam(user.id, parsed_id)

    if !target do
      conn
      |> send_resp(400, "Team not found.")
    else
      tasks = TaskManager.getTaskOfTeam(teamID)

      conn
      |> put_status(200)
      |> render("list_.json", tasks: tasks)
    end
  end

  def create_task_of_team(conn, %{"teamID" => teamID, "task" => %{"name" => name}}) do
    user = Guardian.Plug.current_resource(conn)
    {parsed_id, _} = Integer.parse(teamID)

    target = TeamManager.getTeam(user.id, parsed_id)

    if !target || target.is_owner == false do
      conn
      |> send_resp(400, "Team not found.")
    else
      task_params = %{
        name: name,
        complete: false
      }

      with {:ok, task} <- TaskManager.create_task(task_params, target.team_id) do
        conn
        |> put_status(:created)
        |> render("task_.json", task: task)
      else
        {:error, msg} ->
          conn
          |> send_resp(400, to_string(msg))
      end
    end
  end

  def delete_task_of_team(conn, %{"teamID" => teamID, "taskID" => taskID}) do
    user = Guardian.Plug.current_resource(conn)
    {parsed_id, _} = Integer.parse(teamID)

    target = TeamManager.getTeam(user.id, parsed_id)

    if !target || target.is_owner == false do
      conn
      |> send_resp(400, "Team not found.")
    else
      {parsed_id_task, _} = Integer.parse(taskID)

      with {:ok, _} <- TaskManager.delete_task(TaskManager.get_task(parsed_id_task)) do
        conn
        |> send_resp(200, "Delete complete.")
      end
    end
  end
end
