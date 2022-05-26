defmodule Faunus.Changeset do
  import Ecto.Changeset

  def validate_max_255_chars(changeset, fields) do
    fields
    |> List.wrap()
    |> Enum.reduce(changeset, &validate_length(&2, &1, max: 255))
  end

  @date_comparison_dict %{lt: "before", eq: "equal to", gt: "after"}

  def validate_dates(%{valid?: true} = changeset, first_date_field, criteria, second_date_field) do
    criteria = List.wrap(criteria)

    with {_, first_date} when not is_nil(first_date) <-
           fetch_field(changeset, first_date_field),
         {_, second_date} when not is_nil(second_date) <-
           fetch_field(changeset, second_date_field),
         comparison <- Date.compare(first_date, second_date),
         true <- Enum.member?(criteria, comparison) do
      changeset
    else
      false ->
        criteria_string = join_criteria(criteria, @date_comparison_dict)

        add_error(changeset, first_date_field, "must be #{criteria_string} #{second_date_field}")

      _ ->
        changeset
    end
  end

  def validate_dates(changeset, _, _, _), do: changeset

  defp join_criteria(criteria, dict) do
    criteria
    |> Enum.map(fn item -> Map.get(dict, item) end)
    |> Enum.join(" or ")
  end
end
