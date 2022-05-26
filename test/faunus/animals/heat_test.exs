defmodule Faunus.Animals.HeatTest do
  use Faunus.DataCase, async: true

  alias Faunus.Animals.Heat

  describe "create_changeset/2" do
    test "valid attrs" do
      attrs = params_with_assocs(:heat)

      changeset = Heat.create_changeset(attrs)

      assert changeset.valid?
      assert changeset.changes == attrs
    end

    test "missing required attrs" do
      changeset = Heat.create_changeset(%{})

      assert errors_on(changeset) == %{
               detected_at: ["can't be blank"],
               animal_id: ["can't be blank"]
             }
    end

    test "`animal` assoc constraint" do
      attrs = params_with_assocs(:heat) |> Map.put(:animal_id, UUID.generate())

      {:error, changeset} = attrs |> Heat.create_changeset() |> Repo.insert()

      assert errors_on(changeset) == %{
               animal: ["does not exist"]
             }
    end
  end
end
