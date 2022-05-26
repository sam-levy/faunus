defmodule Faunus.Repo.Migrations.CreateAnimalMedicationsTable do
  use Ecto.Migration

  def change do
    create table(:animal_medications) do
      add :dose, :float, null: false
      add :given_at, :date, null: false

      add :animal_id, references(:animals), null: false
      add :medicine_id, references(:medicines), null: false

      timestamps()
    end
  end
end
