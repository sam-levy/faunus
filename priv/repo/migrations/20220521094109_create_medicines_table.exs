defmodule Faunus.Repo.Migrations.CreateMedicinesTable do
  use Ecto.Migration

  def change do
    create table(:medicines) do
      add :name, :citext, null: false

      timestamps()
    end

    create unique_index(:medicines, [:name])
  end
end
