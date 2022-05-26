defmodule Faunus.Repo.Migrations.CreateAnimalLogsTable do
  use Ecto.Migration

  def change do
    create table(:animal_logs) do
      add :content, :text, null: false
      add :date, :date, null: false

      add :animal_id, references(:animals), null: false

      timestamps()
    end
  end
end
