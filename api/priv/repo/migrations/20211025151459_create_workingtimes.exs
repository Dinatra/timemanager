defmodule Timemachine.Repo.Migrations.CreateWorkingtimes do
  use Ecto.Migration

  def change do
    create table(:workingtimes) do
      add :start, :utc_datetime, null: false
      add :end, :utc_datetime, null: false
      add :pause, :integer, null: false
      add :comment, :string, null: true
      add :name, :string, null: true
      add :user_id, references(:users, on_delete: :nothing), null: false

      timestamps()
    end

    create index(:workingtimes, [:user_id])
  end
end
