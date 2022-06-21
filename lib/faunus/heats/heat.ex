defmodule Faunus.Heats.Heat do
  use Faunus.Schema

  alias Faunus.Animals.Animal

  schema "heats" do
    field :detected_at, :date

    belongs_to :animal, Animal

    timestamps()
  end

  @fields [:detected_at, :animal_id]

  def create_changeset(%{} = attrs) do
    %__MODULE__{}
    |> cast(attrs, @fields)
    |> validate_required(@fields)
    |> assoc_constraint(:animal)
  end
end
