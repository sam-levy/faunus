defmodule Faunus.Weighings.Weighing do
  use Faunus.Schema

  alias Faunus.Animals.Animal

  schema "weighings" do
    field :measure_in_kg, :integer
    field :date, :date

    belongs_to :animal, Animal

    timestamps()
  end

  @required_fields [:measure_in_kg, :date, :animal_id]
  @optional_fields []

  def create_changeset(%{} = attrs) do
    %__MODULE__{}
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> validate_number(:measure_in_kg, greater_than: 0)
    |> assoc_constraint(:animal)
  end
end
