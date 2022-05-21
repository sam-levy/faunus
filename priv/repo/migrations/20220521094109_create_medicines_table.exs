defmodule Faunus.Repo.Migrations.CreateMedicinesTable do
  use Ecto.Migration

  def change do
    create table(:medicines) do
      add :name, :string, null: false

      timestamps()
    end
  end
end
