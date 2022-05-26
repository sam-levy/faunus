defmodule Faunus.Repo.Migrations.CreateAnimalsTable do
  use Ecto.Migration
  import EctoEnumMigration

  def change do
    create_type(:gender, [:male, :female])

    create table(:animals) do
      add :name, :citext, null: false
      add :gender, :gender, null: false
      add :is_currently_owned, :boolean, null: false, default: true
      add :internal_code, :citext
      add :birth_date, :date
      add :death_date, :date

      add :breed_id, references(:breeds), null: false
      add :origin_id, references(:origins), null: false

      timestamps()
    end

    create unique_index(:animals, [:internal_code])

    create unique_index(:animals, [:name],
             where: "is_currently_owned = true AND death_date IS NULL"
           )

    create constraint(:animals, :animals_death_date_gt_or_eq_birth_date,
             check: "death_date >= birth_date"
           )

    create constraint(:animals, :animals_is_currently_owned_true_internal_code_not_null,
             check: """
             CASE WHEN is_currently_owned = true THEN
               internal_code IS NOT NULL
             END
             """
           )

    create constraint(:animals, :animals_is_currently_owned_true_birth_date_not_null,
             check: """
             CASE WHEN is_currently_owned = true THEN
               birth_date IS NOT NULL
             END
             """
           )
  end
end
