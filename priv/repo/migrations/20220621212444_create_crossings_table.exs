defmodule Faunus.Repo.Migrations.CreateCrossingsTable do
  use Ecto.Migration
  import EctoEnumMigration

  def change do
    create_type(:crossing_technique, [
      :natural_breeding,
      :artificial_insemination,
      :embryo_transfer
    ])

    create_type(:crossing_status, [:pending, :pregnant, :failed, :aborted, :born])

    create table(:crossings) do
      add :technique, :crossing_technique, null: false
      add :date, :date, null: false
      add :status, :crossing_status, null: false, default: "pending"

      add :pregnancy_test_at, :date
      add :aborted_at, :date
      add :birth_date, :date

      add :heat_id, references(:heats), null: false

      add :semen_id, references(:animals), null: false
      add :ovule_id, references(:animals), null: false
      add :host_id, references(:animals), null: false

      timestamps()
    end

    create constraint(:crossings, :crossings_birth_date_gt_pregnancy_test_at,
             check: "birth_date > pregnancy_test_at"
           )

    create constraint(:crossings, :crossings_aborted_at_gt_or_eq_pregnancy_test_at,
             check: "aborted_at >= pregnancy_test_at"
           )

    create constraint(:crossings, :crossings_semen_id_diff_than_ovule_id_and_host_id,
             check: "semen_id != ovule_id AND semen_id != host_id"
           )

    create constraint(:crossings, :crossings_status_conditionals,
             check: """
             CASE
               WHEN status = 'pending' THEN
                 pregnancy_test_at IS NULL AND
                 aborted_at IS NULL AND
                 birth_date IS NULL
               WHEN (status = 'pregnant' OR status = 'failed')  THEN
                 pregnancy_test_at IS NOT NULL AND
                 aborted_at IS NULL AND
                 birth_date IS NULL
               WHEN status = 'aborted' THEN
                 pregnancy_test_at IS NOT NULL AND
                 aborted_at IS NOT NULL AND
                 birth_date IS NULL
               WHEN status = 'born' THEN
                 pregnancy_test_at IS NOT NULL AND
                 aborted_at IS NULL AND
                 birth_date IS NOT NULL
             END
             """
           )
  end
end
