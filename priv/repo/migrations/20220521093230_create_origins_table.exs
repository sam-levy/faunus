defmodule Faunus.Repo.Migrations.CreateOriginsTable do
  use Ecto.Migration

  def change do
    create table(:origins) do
      add :name, :citext, null: false

      timestamps()
    end

    create unique_index(:origins, [:name])
  end
end
