defmodule Faunus.Repo.Migrations.CreateAnimalWeighingsTable do
  use Ecto.Migration

  def change do
    create table(:weighings) do
      add :measure_in_kg, :integer, null: false
      add :date, :date, null: false

      add :animal_id, references(:animals), null: false

      timestamps()
    end

    create constraint(:weighings, :weighings_measure_in_kg_greather_than_zero,
             check: "measure_in_kg > 0"
           )
  end
end
