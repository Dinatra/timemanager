defmodule Timemachine.Repo.Migrations.CreateTasks do
  use Ecto.Migration

  def change do
    create table(:tasks) do
      add :name, :string, null: false
      add :complete, :boolean, null: false

      add :team_id, references(:teams, on_delete: :nothing)

      timestamps()
    end

    create index(:tasks, [:team_id])
    create unique_index(:tasks, [:name])
  end
end
