defmodule TimemachineWeb.TaskView do
  use TimemachineWeb, :view
  alias TimemachineWeb.TaskView

  def render("list.json", %{tasks: tasks}) do
    %{data: render_many(tasks, TaskView, "task.json")}
  end

  def render("task.json", %{task: task}) do
    %{
      id: task.task_id,
      name: task.task.name
    }
  end


  def render("list_.json", %{tasks: tasks}) do
    %{data: render_many(tasks, TaskView, "task_.json")}
  end

  def render("task_.json", %{task: task}) do
    %{
      id: task.id,
      name: task.name,
      complete: task.complete,
    }
  end
end
