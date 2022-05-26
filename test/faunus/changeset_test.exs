defmodule Faunus.ChangesetTest do
  use Faunus.DataCase, async: true

  describe "validate_max_255_chars/2" do
    test "one valid field" do
      data = %{}
      types = %{name: :string}
      params = %{name: "valid_length"}

      changeset =
        {data, types}
        |> Ecto.Changeset.cast(params, Map.keys(types))
        |> Faunus.Changeset.validate_max_255_chars(:name)

      assert changeset.valid?
    end

    test "multiple valid fields" do
      data = %{}
      types = %{name: :string, code: :string}
      params = %{name: "valid_length", code: "valid_length"}

      changeset =
        {data, types}
        |> Ecto.Changeset.cast(params, Map.keys(types))
        |> Faunus.Changeset.validate_max_255_chars([:name, :code])

      assert changeset.valid?
    end

    test "one invalid field" do
      data = %{}
      types = %{name: :string, code: :string}
      params = %{name: "valid_length", code: String.duplicate("a", 256)}

      changeset =
        {data, types}
        |> Ecto.Changeset.cast(params, Map.keys(types))
        |> Faunus.Changeset.validate_max_255_chars([:name, :code])

      refute changeset.valid?

      assert errors_on(changeset) == %{code: ["should be at most 255 character(s)"]}
    end

    test "multiple invalid fields" do
      data = %{}
      types = %{name: :string, code: :string}
      params = %{name: String.duplicate("a", 256), code: String.duplicate("a", 256)}

      changeset =
        {data, types}
        |> Ecto.Changeset.cast(params, Map.keys(types))
        |> Faunus.Changeset.validate_max_255_chars([:name, :code])

      refute changeset.valid?

      assert errors_on(changeset) == %{
               name: ["should be at most 255 character(s)"],
               code: ["should be at most 255 character(s)"]
             }
    end
  end

  describe "validate_dates/4" do
    test "skips when first_date is nil" do
      data = %{}
      types = %{first_date: :date, second_date: :date}
      params = %{first_date: nil, second_date: ~D[2021-01-01]}

      changeset =
        {data, types}
        |> Ecto.Changeset.cast(params, Map.keys(types))
        |> Faunus.Changeset.validate_dates(:first_date, :lt, :second_date)

      assert changeset.valid?
    end

    test "skips when second_date is nil" do
      data = %{}
      types = %{first_date: :date, second_date: :date}
      params = %{first_date: ~D[2020-01-01], second_date: nil}

      changeset =
        {data, types}
        |> Ecto.Changeset.cast(params, Map.keys(types))
        |> Faunus.Changeset.validate_dates(:first_date, :lt, :second_date)

      assert changeset.valid?
    end

    test "skips when both dates are nil" do
      data = %{}
      types = %{first_date: :date, second_date: :date}
      params = %{first_date: nil, second_date: nil}

      changeset =
        {data, types}
        |> Ecto.Changeset.cast(params, Map.keys(types))
        |> Faunus.Changeset.validate_dates(:first_date, :lt, :second_date)

      assert changeset.valid?
    end

    test ":lt true" do
      data = %{}
      types = %{first_date: :date, second_date: :date}
      params = %{first_date: ~D[2020-01-01], second_date: ~D[2021-01-01]}

      changeset =
        {data, types}
        |> Ecto.Changeset.cast(params, Map.keys(types))
        |> Faunus.Changeset.validate_dates(:first_date, :lt, :second_date)

      assert changeset.valid?
    end

    test ":lt false" do
      data = %{}
      types = %{first_date: :date, second_date: :date}
      params = %{first_date: ~D[2021-01-01], second_date: ~D[2020-01-01]}

      changeset =
        {data, types}
        |> Ecto.Changeset.cast(params, Map.keys(types))
        |> Faunus.Changeset.validate_dates(:first_date, :lt, :second_date)

      refute changeset.valid?

      assert errors_on(changeset) == %{first_date: ["must be before second_date"]}
    end

    test ":eq true" do
      data = %{}
      types = %{first_date: :date, second_date: :date}
      params = %{first_date: ~D[2021-01-01], second_date: ~D[2021-01-01]}

      changeset =
        {data, types}
        |> Ecto.Changeset.cast(params, Map.keys(types))
        |> Faunus.Changeset.validate_dates(:first_date, :eq, :second_date)

      assert changeset.valid?
    end

    test ":eq false" do
      data = %{}
      types = %{first_date: :date, second_date: :date}
      params = %{first_date: ~D[2021-01-01], second_date: ~D[2020-01-01]}

      changeset =
        {data, types}
        |> Ecto.Changeset.cast(params, Map.keys(types))
        |> Faunus.Changeset.validate_dates(:first_date, :eq, :second_date)

      refute changeset.valid?

      assert errors_on(changeset) == %{first_date: ["must be equal to second_date"]}
    end

    test ":gt true" do
      data = %{}
      types = %{first_date: :date, second_date: :date}
      params = %{first_date: ~D[2021-01-01], second_date: ~D[2020-01-01]}

      changeset =
        {data, types}
        |> Ecto.Changeset.cast(params, Map.keys(types))
        |> Faunus.Changeset.validate_dates(:first_date, :gt, :second_date)

      assert changeset.valid?
    end

    test ":gt false" do
      data = %{}
      types = %{first_date: :date, second_date: :date}
      params = %{first_date: ~D[2020-01-01], second_date: ~D[2021-01-01]}

      changeset =
        {data, types}
        |> Ecto.Changeset.cast(params, Map.keys(types))
        |> Faunus.Changeset.validate_dates(:first_date, :gt, :second_date)

      refute changeset.valid?

      assert errors_on(changeset) == %{first_date: ["must be after second_date"]}
    end

    test "[:lt, :eq] true when :lt" do
      data = %{}
      types = %{first_date: :date, second_date: :date}
      params = %{first_date: ~D[2020-01-01], second_date: ~D[2021-01-01]}

      changeset =
        {data, types}
        |> Ecto.Changeset.cast(params, Map.keys(types))
        |> Faunus.Changeset.validate_dates(:first_date, [:lt, :eq], :second_date)

      assert changeset.valid?
    end

    test "[:lt, :eq] true when :eq" do
      data = %{}
      types = %{first_date: :date, second_date: :date}
      params = %{first_date: ~D[2021-01-01], second_date: ~D[2021-01-01]}

      changeset =
        {data, types}
        |> Ecto.Changeset.cast(params, Map.keys(types))
        |> Faunus.Changeset.validate_dates(:first_date, [:lt, :eq], :second_date)

      assert changeset.valid?
    end

    test "[:lt, :eq] false when :gt" do
      data = %{}
      types = %{first_date: :date, second_date: :date}
      params = %{first_date: ~D[2021-01-01], second_date: ~D[2020-01-01]}

      changeset =
        {data, types}
        |> Ecto.Changeset.cast(params, Map.keys(types))
        |> Faunus.Changeset.validate_dates(:first_date, [:lt, :eq], :second_date)

      refute changeset.valid?

      assert errors_on(changeset) == %{first_date: ["must be before or equal to second_date"]}
    end

    test "[:eq, :gt] true when :eq" do
      data = %{}
      types = %{first_date: :date, second_date: :date}
      params = %{first_date: ~D[2021-01-01], second_date: ~D[2021-01-01]}

      changeset =
        {data, types}
        |> Ecto.Changeset.cast(params, Map.keys(types))
        |> Faunus.Changeset.validate_dates(:first_date, [:eq, :gt], :second_date)

      assert changeset.valid?
    end

    test "[:eq, :gt] true when :gt" do
      data = %{}
      types = %{first_date: :date, second_date: :date}
      params = %{first_date: ~D[2021-01-01], second_date: ~D[2020-01-01]}

      changeset =
        {data, types}
        |> Ecto.Changeset.cast(params, Map.keys(types))
        |> Faunus.Changeset.validate_dates(:first_date, [:eq, :gt], :second_date)

      assert changeset.valid?
    end

    test "[:eq, :gt] false when :lt" do
      data = %{}
      types = %{first_date: :date, second_date: :date}
      params = %{first_date: ~D[2020-01-01], second_date: ~D[2021-01-01]}

      changeset =
        {data, types}
        |> Ecto.Changeset.cast(params, Map.keys(types))
        |> Faunus.Changeset.validate_dates(:first_date, [:eq, :gt], :second_date)

      refute changeset.valid?

      assert errors_on(changeset) == %{first_date: ["must be equal to or after second_date"]}
    end
  end
end
