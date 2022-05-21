defmodule Faunus.Repo.Migrations.CreateDeseasesTable do
  use Ecto.Migration

  def change do
    create table(:deseases) do
      add :name, :string, null: false

      timestamps()
    end
  end
end
