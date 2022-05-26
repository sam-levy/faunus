defmodule Faunus.Repo.Migrations.CreateAnimalDeseasesTable do
  use Ecto.Migration

  def change do
    create table(:animal_deseases) do
      add :detected_at, :date, null: false
      add :healed_at, :date

      add :animal_id, references(:animals), null: false
      add :desease_id, references(:deseases), null: false

      timestamps()
    end

    create constraint(:animal_deseases, :animal_deseases_healed_at_gt_or_eq_detected_at,
             check: "healed_at >= detected_at"
           )
  end
end
