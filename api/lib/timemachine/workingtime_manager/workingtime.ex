defmodule Timemachine.WorkingtimeManager.Workingtime do
  use Ecto.Schema
  import Ecto.Changeset

  schema "workingtimes" do
    field :end, :utc_datetime, null: false
    field :start, :utc_datetime, null: false
    field :pause, :integer, null: false
    field :comment, :string, null: true
    field :name, :string, null: true
    belongs_to :user, Timemachine.UserManager.User

    timestamps()
  end

  @doc false
  def changeset(workingtime, attrs) do
    workingtime
    |> cast(attrs, [:start, :end, :pause, :comment, :name])
    |> validate_required([:start, :end, :pause])
  end
end
