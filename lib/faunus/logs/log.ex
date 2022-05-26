defmodule Faunus.Logs.Log do
  use Faunus.Schema

  alias Faunus.Animals.Animal

  schema "animal_logs" do
    field :content, :string
    field :date, :date

    belongs_to :animal, Animal

    timestamps()
  end

  @required_fields [:content, :date, :animal_id]
  @optional_fields []

  def create_changeset(%{} = attrs) do
    %__MODULE__{}
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> assoc_constraint(:animal)
  end
end
