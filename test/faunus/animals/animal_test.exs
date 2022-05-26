defmodule Faunus.Animals.AnimalTest do
  use Faunus.DataCase, async: true

  alias Faunus.Animals.Animal

  describe "create_changeset/2" do
    test "valid attrs" do
      attrs = params_with_assocs(:animal)

      changeset = Animal.create_changeset(attrs)

      assert changeset.valid?
      assert changeset.changes == attrs
    end

    test "missing required attrs" do
      changeset = Animal.create_changeset(%{})

      assert errors_on(changeset) == %{
               name: ["can't be blank"],
               gender: ["can't be blank"],
               is_currently_owned: ["can't be blank"],
               breed_id: ["can't be blank"],
               origin_id: ["can't be blank"]
             }
    end

    test "string fields bigger than 255 chars" do
      big_string = String.duplicate("a", 256)

      attrs = params_with_assocs(:animal, name: big_string, internal_code: big_string)

      changeset = Animal.create_changeset(attrs)

      assert errors_on(changeset) == %{
               name: ["should be at most 255 character(s)"],
               internal_code: ["should be at most 255 character(s)"]
             }
    end

    test "`death_date` before `birth_date`" do
      attrs =
        params_with_assocs(:animal,
          birth_date: Date.utc_today(),
          death_date: Date.utc_today() |> Date.add(-1)
        )

      changeset = Animal.create_changeset(attrs)

      assert errors_on(changeset) == %{
               death_date: ["must be after or equal to birth_date"]
             }
    end

    test "`breed` assoc constraint" do
      attrs = params_with_assocs(:animal) |> Map.put(:breed_id, UUID.generate())

      {:error, changeset} = attrs |> Animal.create_changeset() |> Repo.insert()

      assert errors_on(changeset) == %{
               breed: ["does not exist"]
             }
    end

    test "`origin` assoc constraint" do
      attrs = params_with_assocs(:animal) |> Map.put(:origin_id, UUID.generate())

      {:error, changeset} = attrs |> Animal.create_changeset() |> Repo.insert()

      assert errors_on(changeset) == %{
               origin: ["does not exist"]
             }
    end

    test "`internal_code` unique constraint" do
      insert(:animal, internal_code: "A")
      attrs = params_with_assocs(:animal, internal_code: "A")

      {:error, changeset} = attrs |> Animal.create_changeset() |> Repo.insert()

      assert errors_on(changeset) == %{
               internal_code: ["has already been taken"]
             }
    end

    test "`name` conditional unique constraint when `is_currently_owned` true" do
      fields = %{name: "Mimosa", is_currently_owned: true, death_date: nil}

      insert(:animal, fields)

      attrs = params_with_assocs(:animal, fields)

      {:error, changeset} = attrs |> Animal.create_changeset() |> Repo.insert()

      assert errors_on(changeset) == %{
               name: ["has already been taken"]
             }
    end

    test "`name` conditional unique constraint when `is_currently_owned` false" do
      fields = %{name: "Mimosa", is_currently_owned: false, death_date: nil}

      insert(:animal, fields)
      attrs = params_with_assocs(:animal, %{fields | is_currently_owned: true})

      assert {:ok, %Animal{}} = attrs |> Animal.create_changeset() |> Repo.insert()
    end

    test "`name` conditional unique constraint when dead" do
      fields = %{name: "Mimosa", is_currently_owned: true, death_date: Date.utc_today()}

      insert(:animal, fields)
      attrs = params_with_assocs(:animal, %{fields | death_date: nil})

      assert {:ok, %Animal{}} = attrs |> Animal.create_changeset() |> Repo.insert()
    end

    test "`internal_code` not null when `is_currently_owned` true conditional constraint" do
      attrs = params_with_assocs(:animal, is_currently_owned: true, internal_code: nil)

      assert {:error, changeset} = attrs |> Animal.create_changeset() |> Repo.insert()

      assert errors_on(changeset) == %{
               internal_code: ["can't be blank when animal is owned"]
             }
    end

    test "`birth_date` not null when `is_currently_owned` true conditional constraint" do
      attrs = params_with_assocs(:animal, is_currently_owned: true, birth_date: nil)

      assert {:error, changeset} = attrs |> Animal.create_changeset() |> Repo.insert()

      assert errors_on(changeset) == %{
               birth_date: ["can't be blank when animal is owned"]
             }
    end

    test "`internal_code` and `birth_date` null when `is_currently_owned` false" do
      attrs =
        params_with_assocs(:animal, is_currently_owned: false, internal_code: nil, birth_date: nil)

      assert {:ok, %Animal{}} = attrs |> Animal.create_changeset() |> Repo.insert()
    end
  end
end
