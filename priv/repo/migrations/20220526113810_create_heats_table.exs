defmodule Faunus.Repo.Migrations.CreateHeatsTable do
  use Ecto.Migration

  def change do
    create table(:animal_heats) do
      add :detected_at, :date, null: false

      add :animal_id, references(:animals), null: false

      timestamps()
    end
  end
end
