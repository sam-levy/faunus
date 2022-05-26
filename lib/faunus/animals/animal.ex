defmodule Faunus.Animals.Animal do
  use Faunus.Schema

  alias Faunus.Animals.{Breed, Origin}

  schema "animals" do
    field :name, :string
    field :gender, Ecto.Enum, values: [:male, :female]
    field :is_currently_owned, :boolean
    field :internal_code, :string
    field :birth_date, :date
    field :death_date, :date

    belongs_to :breed, Breed
    belongs_to :origin, Origin

    timestamps()
  end

  @required_fields [:name, :gender, :is_currently_owned, :breed_id, :origin_id]
  @optional_fields [:internal_code, :birth_date, :death_date]

  @is_currently_owned_true_not_null_message "can't be blank when animal is owned"

  def create_changeset(%{} = attrs) do
    %__MODULE__{}
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> validate_max_255_chars([:name, :internal_code])
    |> validate_dates(:death_date, [:gt, :eq], :birth_date)
    |> unique_constraint(:internal_code)
    |> unique_constraint(:name)
    |> check_constraint(:internal_code,
      name: :animals_is_currently_owned_true_internal_code_not_null,
      message: @is_currently_owned_true_not_null_message
    )
    |> check_constraint(:birth_date,
      name: :animals_is_currently_owned_true_birth_date_not_null,
      message: @is_currently_owned_true_not_null_message
    )
    |> assoc_constraint(:breed)
    |> assoc_constraint(:origin)
  end
end
