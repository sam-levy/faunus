defmodule Faunus.Repo.Migrations.CreateDeseasesTable do
  use Ecto.Migration

  def change do
    create table(:deseases) do
      add :name, :citext, null: false

      timestamps()
    end

    create unique_index(:deseases, [:name])
  end
end
