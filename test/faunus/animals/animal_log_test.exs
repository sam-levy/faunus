defmodule Faunus.Animals.AnimalLogTest do
  use Faunus.DataCase, async: true

  alias Faunus.Animals.AnimalLog

  describe "create_changeset/2" do
    test "valid attrs" do
      attrs = params_with_assocs(:animal_log)

      changeset = AnimalLog.create_changeset(attrs)

      assert changeset.valid?
      assert changeset.changes == attrs
    end

    test "missing required attrs" do
      changeset = AnimalLog.create_changeset(%{})

      assert errors_on(changeset) == %{
               content: ["can't be blank"],
               date: ["can't be blank"],
               animal_id: ["can't be blank"]
             }
    end

    test "`animal` assoc constraint" do
      attrs = params_with_assocs(:animal_log) |> Map.put(:animal_id, UUID.generate())

      {:error, changeset} = attrs |> AnimalLog.create_changeset() |> Repo.insert()

      assert errors_on(changeset) == %{
               animal: ["does not exist"]
             }
    end
  end
end
