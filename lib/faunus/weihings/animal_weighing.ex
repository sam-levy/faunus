defmodule Faunus.Weighings.Weighing do
  use Faunus.Schema

  alias Faunus.Animals.Animal

  schema "weighings" do
    field :measure_in_kg, :integer
    field :date, :date

    belongs_to :animal, Animal

    timestamps()
  end

  @fields [:measure_in_kg, :date, :animal_id]

  def create_changeset(%{} = attrs) do
    %__MODULE__{}
    |> cast(attrs, @fields)
    |> validate_required(@fields)
    |> validate_number(:measure_in_kg, greater_than: 0)
    |> assoc_constraint(:animal)
  end
end
