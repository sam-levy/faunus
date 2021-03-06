defmodule Faunus.Weighings.WeighingTest do
  use Faunus.DataCase, async: true

  alias Faunus.Weighings.Weighing

  describe "create_changeset/2" do
    test "valid attrs" do
      attrs = params_with_assocs(:animal_weighing)

      changeset = Weighing.create_changeset(attrs)

      assert changeset.valid?
      assert changeset.changes == attrs
    end

    test "missing required attrs" do
      changeset = Weighing.create_changeset(%{})

      assert errors_on(changeset) == %{
               measure_in_kg: ["can't be blank"],
               date: ["can't be blank"],
               animal_id: ["can't be blank"]
             }
    end

    test "`measure_in_kg` equal to zero" do
      attrs = params_with_assocs(:animal_weighing, measure_in_kg: 0)

      changeset = Weighing.create_changeset(attrs)

      assert errors_on(changeset) == %{
               measure_in_kg: ["must be greater than 0"]
             }
    end

    test "`animal` assoc constraint" do
      attrs = params_with_assocs(:animal_weighing) |> Map.put(:animal_id, UUID.generate())

      {:error, changeset} = attrs |> Weighing.create_changeset() |> Repo.insert()

      assert errors_on(changeset) == %{
               animal: ["does not exist"]
             }
    end
  end
end
