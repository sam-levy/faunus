defmodule Faunus.Animals.Breed do
  use Faunus.Schema

  schema "breeds" do
    field :name, :string

    timestamps()
  end

  def changeset(%__MODULE__{} = target \\ %__MODULE__{}, attrs) do
    target
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> validate_length(:name, max: 255)
  end
end