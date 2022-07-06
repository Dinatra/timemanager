defmodule Timemachine.TeamManager.Team do
  use Ecto.Schema
  import Ecto.Changeset

  schema "teams" do
    field :name, :string, null: false

    many_to_many :users, Timemachine.UserManager.User,
      join_through: "users_teams",
      on_replace: :delete

    timestamps()
  end

  @doc false
  def changeset(clock, attrs) do
    clock
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> validate_length(:name, min: 3, max: 32)
  end
end
