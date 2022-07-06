defmodule Timemachine.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :username, :string, null: false
      add :email, :string, null: false
      add :password, :string, null: false
      add :last_logout, :utc_datetime
      add :role, :string
      add :team_id, references(:teams, on_delete: :nothing), null: true

      timestamps()
    end

    create unique_index(:users, [:username])
    create unique_index(:users, [:email])
  end
end
