defmodule Faunus.Animals.Heat do
  use Faunus.Schema

  alias Faunus.Animals.Animal

  schema "animal_heats" do
    field :detected_at, :date

    belongs_to :animal, Animal

    timestamps()
  end

  @required_fields [:detected_at, :animal_id]
  @optional_fields []

  def create_changeset(%{} = attrs) do
    %__MODULE__{}
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> assoc_constraint(:animal)
  end
end
