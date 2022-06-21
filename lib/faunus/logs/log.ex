defmodule Faunus.Logs.Log do
  use Faunus.Schema

  alias Faunus.Animals.Animal

  schema "animal_logs" do
    field :content, :string
    field :date, :date

    belongs_to :animal, Animal

    timestamps()
  end

  @fields [:content, :date, :animal_id]

  def create_changeset(%{} = attrs) do
    %__MODULE__{}
    |> cast(attrs, @fields)
    |> validate_required(@fields)
    |> assoc_constraint(:animal)
  end
end
