defmodule Faunus.Animals.AnimalMedicationTest do
  use Faunus.DataCase, async: true

  alias Faunus.Animals.AnimalMedication

  describe "create_changeset/2" do
    test "valid attrs" do
      attrs = params_with_assocs(:animal_medication)

      changeset = AnimalMedication.create_changeset(attrs)

      assert changeset.valid?
      assert changeset.changes == attrs
    end

    test "missing required attrs" do
      changeset = AnimalMedication.create_changeset(%{})

      assert errors_on(changeset) == %{
               dose: ["can't be blank"],
               given_at: ["can't be blank"],
               animal_id: ["can't be blank"],
               medicine_id: ["can't be blank"]
             }
    end

    test "`animal` assoc constraint" do
      attrs = params_with_assocs(:animal_medication) |> Map.put(:animal_id, UUID.generate())

      {:error, changeset} = attrs |> AnimalMedication.create_changeset() |> Repo.insert()

      assert errors_on(changeset) == %{
               animal: ["does not exist"]
             }
    end

    test "`medicine` assoc constraint" do
      attrs = params_with_assocs(:animal_medication) |> Map.put(:medicine_id, UUID.generate())

      {:error, changeset} = attrs |> AnimalMedication.create_changeset() |> Repo.insert()

      assert errors_on(changeset) == %{
               medicine: ["does not exist"]
             }
    end
  end
end
