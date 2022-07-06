defmodule Timemachine.UserManager.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string, null: false
    field :username, :string, null: false
    field :password, :string, null: false
    field :last_logout, :utc_datetime
    field :role, Ecto.Enum, values: [:manager, :super_manager, nil]

    has_many :workingtimes, Timemachine.WorkingtimeManager.Workingtime
    has_many :clocks, Timemachine.ClockManager.Clock

    # many_to_many :teams, Timemachine.TeamManager.Team,
    #   join_through: "users_teams",
    #   on_replace: :delete

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:last_logout, :username, :email, :password, :role])
    |> validate_required([:username, :email, :password])
    |> validate_length(:username, min: 3, max: 64)
    |> validate_length(:password, min: 8, max: 64)
    |> validate_format(:email, ~r/^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$/)
    |> unique_constraint(:email)
    |> unique_constraint(:username)
    |> put_password_hash()
  end

  defp put_password_hash(
         %Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset
       ) do
    change(changeset, password: Bcrypt.hash_pwd_salt(password))
  end

  defp put_password_hash(changeset), do: changeset
end
