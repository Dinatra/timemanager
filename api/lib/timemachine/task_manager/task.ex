defmodule Timemachine.TaskManager.Task do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tasks" do
    field :name, :string, null: false
    field :complete, :boolean, null: false
    belongs_to :team, Timemachine.TeamManager.Team

    timestamps()
  end

  @doc false
  def changeset(clock, attrs) do
    clock
    |> cast(attrs, [:name, :complete])
    |> validate_required([:name, :complete])
    |> validate_length(:name, min: 3, max: 32)
  end
end
