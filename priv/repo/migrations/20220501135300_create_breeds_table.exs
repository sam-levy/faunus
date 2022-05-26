defmodule Faunus.Repo.Migrations.CreateBreedsTable do
  use Ecto.Migration

  def change do
    execute "CREATE EXTENSION IF NOT EXISTS citext", ""

    create table(:breeds) do
      add :name, :citext, null: false

      timestamps()
    end

    create unique_index(:breeds, [:name])
  end
end
