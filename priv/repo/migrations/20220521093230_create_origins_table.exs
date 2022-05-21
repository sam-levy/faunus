defmodule Faunus.Repo.Migrations.CreateOriginsTable do
  use Ecto.Migration

  def change do
    create table(:origins) do
      add :name, :string, null: false

      timestamps()
    end
  end
end
