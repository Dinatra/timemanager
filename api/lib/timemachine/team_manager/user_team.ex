defmodule Timemachine.TeamManager.UserTeam do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users_teams" do
    field :is_owner, :boolean, null: false

    belongs_to :user, Timemachine.UserManager.User
    belongs_to :team, Timemachine.TeamManager.Team

    timestamps()
  end

  @doc false
  def changeset(user_team, attrs) do
    user_team
    |> cast(attrs, [:user_id, :team_id, :is_owner])
    |> validate_required([:user_id, :team_id, :is_owner])
    |> foreign_key_constraint(:team_id)
    |> foreign_key_constraint(:user_id)
    |> unique_constraint([:user, :team],
      name: :user_id_team_id_unique_index,
      message: "ALREADY_EXISTS"
    )
  end
end
