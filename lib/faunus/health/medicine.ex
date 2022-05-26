defmodule Faunus.Health.Medicine do
  use Faunus.Schema

  schema "medicines" do
    field :name, :string

    timestamps()
  end

  def changeset(%__MODULE__{} = target \\ %__MODULE__{}, attrs) do
    target
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> validate_max_255_chars(:name)
    |> unique_constraint(:name)
  end
end
