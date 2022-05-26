defmodule Faunus.Animals.AnimalDesease do
  use Faunus.Schema

  alias Faunus.Animals.Animal
  alias Faunus.Health.Desease

  schema "animal_deseases" do
    field :detected_at, :date
    field :healed_at, :date

    belongs_to :animal, Animal
    belongs_to :desease, Desease

    timestamps()
  end

  @required_fields [:detected_at, :animal_id, :desease_id]
  @optional_fields [:healed_at]

  def create_changeset(%{} = attrs) do
    %__MODULE__{}
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> validate_dates(:healed_at, [:gt, :eq], :detected_at)
    |> assoc_constraint(:animal)
    |> assoc_constraint(:desease)
  end
end
