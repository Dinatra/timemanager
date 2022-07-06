defmodule Timemachine.ClockManager.Clock do
  use Ecto.Schema
  import Ecto.Changeset

  schema "clocks" do
    field :status, :boolean, default: false, null: false
    field :time, :utc_datetime, null: false
    belongs_to :user, Timemachine.UserManager.User

    timestamps()
  end

  @doc false
  def changeset(clock, attrs) do
    clock
    |> cast(attrs, [:time, :status])
    |> validate_required([:time, :status])
  end
end
