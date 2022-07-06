defmodule TimemachineWeb.TeamView do
  use TimemachineWeb, :view
  alias TimemachineWeb.TeamView

  def render("list.json", %{teams: teams}) do
    %{data: render_many(teams, TeamView, "team.json")}
  end

  def render("team.json", %{team: team}) do
    %{
      id: team.team_id,
      name: team.team.name
    }
  end

  def render("team_.json", %{team: team}) do
    %{
      id: team.id,
      name: team.name
    }
  end
end
