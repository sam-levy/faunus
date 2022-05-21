defmodule Faunus.Repo.Migrations.CreateBreedsTable do
  use Ecto.Migration

  def change do
    create table(:breeds) do
      add :name, :string, null: false

      timestamps()
    end
  end
end
