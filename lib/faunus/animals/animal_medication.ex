defmodule Faunus.Animals.AnimalMedication do
  use Faunus.Schema

  alias Faunus.Animals.Animal
  alias Faunus.Health.Medicine

  schema "animal_medications" do
    field :dose, :float
    field :given_at, :date

    belongs_to :animal, Animal
    belongs_to :medicine, Medicine

    timestamps()
  end

  @fields [:dose, :given_at, :animal_id, :medicine_id]

  def create_changeset(%{} = attrs) do
    %__MODULE__{}
    |> cast(attrs, @fields)
    |> validate_required(@fields)
    |> assoc_constraint(:animal)
    |> assoc_constraint(:medicine)
  end
end
