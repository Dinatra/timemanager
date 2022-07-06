defmodule Timemachine.TaskManager do
  import Ecto.Query, warn: false
  alias Timemachine.Repo

  alias Timemachine.TaskManager.Task

  def getTaskOfTeam(teamID) do
    Repo.all(
      from(t in Timemachine.TaskManager.Task,
        where: t.team_id == ^teamID
      )
    )
  end

  def get_task(id), do: Repo.get(Task, id)

  def delete_task(%Task{} = task), do: Repo.delete(task)

  def create_task(attrs \\ %{}, team_id) do
    %Task{team_id: team_id}
    |> Task.changeset(attrs)
    |> Repo.insert()
  end
end
