defmodule Faunus.Animals.AnimalDeseaseTest do
  use Faunus.DataCase, async: true

  alias Faunus.Animals.AnimalDesease

  describe "create_changeset/2" do
    test "valid attrs" do
      attrs = params_with_assocs(:animal_desease)

      changeset = AnimalDesease.create_changeset(attrs)

      assert changeset.valid?
      assert changeset.changes == attrs
    end

    test "missing required attrs" do
      changeset = AnimalDesease.create_changeset(%{})

      assert errors_on(changeset) == %{
               detected_at: ["can't be blank"],
               animal_id: ["can't be blank"],
               desease_id: ["can't be blank"]
             }
    end

    test "`detected_at` before `healed_at`" do
      attrs =
        params_with_assocs(:animal_desease,
          detected_at: Date.utc_today(),
          healed_at: Date.utc_today() |> Date.add(-1)
        )

      changeset = AnimalDesease.create_changeset(attrs)

      assert errors_on(changeset) == %{
               healed_at: ["must be after or equal to detected_at"]
             }
    end

    test "`animal` assoc constraint" do
      attrs = params_with_assocs(:animal_desease) |> Map.put(:animal_id, UUID.generate())

      {:error, changeset} = attrs |> AnimalDesease.create_changeset() |> Repo.insert()

      assert errors_on(changeset) == %{
               animal: ["does not exist"]
             }
    end

    test "`desease` assoc constraint" do
      attrs = params_with_assocs(:animal_desease) |> Map.put(:desease_id, UUID.generate())

      {:error, changeset} = attrs |> AnimalDesease.create_changeset() |> Repo.insert()

      assert errors_on(changeset) == %{
               desease: ["does not exist"]
             }
    end
  end
end
