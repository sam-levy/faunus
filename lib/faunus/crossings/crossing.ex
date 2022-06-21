defmodule Faunus.Crossings.Crossing do
  use Faunus.Schema

  alias Faunus.Animals.Animal
  alias Faunus.Heats.Heat

  @crossing_techniques [:natural_breeding, :artificial_insemination, :embryo_transfer]
  @crossing_status [:pending, :pregnant, :failed, :aborted, :born]

  schema "crossings" do
    field :technique, Ecto.Enum, values: @crossing_techniques
    field :date, :date
    field :status, Ecto.Enum, values: @crossing_status

    field :pregnancy_test_at, :date
    field :aborted_at, :date
    field :birth_date, :date

    belongs_to :heat, Heat

    belongs_to :semen, Animal
    belongs_to :ovule, Animal
    belongs_to :host, Animal

    timestamps()
  end

  @required_fields [:technique, :date, :heat_id, :semen_id, :ovule_id, :host_id]
  @optional_fields [:status, :pregnancy_test_at, :aborted_at, :birth_date]

  def create_changeset(%{} = attrs) do
    %__MODULE__{}
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> validate_dates(:birth_date, :gt, :pregnancy_test_at)
    |> validate_dates(:aborted_at, [:gt, :eq], :pregnancy_test_at)
    |> check_constraint(:internal_code,
      name: :crossings_semen_id_diff_than_ovule_id_and_host_id,
      message: "the father must be different from the mother or host"
    )
    |> check_constraint(:birth_date,
      name: :crossings_status_conditionals,
      message: "pregnancy_test_at or aborted_at or birth_date is invalid"
    )
    |> assoc_constraint(:heat)
    |> assoc_constraint(:semen)
    |> assoc_constraint(:ovule)
    |> assoc_constraint(:host)
  end
end
