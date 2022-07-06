defmodule Timemachine.Repo.Migrations.CreateUsersTeams do
  use Ecto.Migration

  def change do
    create table(:users_teams) do

      add :user_id, references(:users, on_delete: :delete_all)
      add :team_id, references(:teams, on_delete: :delete_all)
      add :is_owner, :boolean, null: false

      timestamps()
    end

    create unique_index(:users_teams, [:team_id, :user_id])

  end
end
