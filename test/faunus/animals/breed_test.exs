defmodule Faunus.Animals.BreedTest do
  use Faunus.DataCase, async: true

  alias Faunus.Animals.Breed

  describe "changeset/2" do
    test "valid attrs" do
      attrs = params_for(:breed)

      changeset = Breed.changeset(attrs)

      assert changeset.valid?
      assert changeset.changes == attrs

      assert {:ok, %Breed{}} = Repo.insert(changeset)
    end

    test "missing required attrs" do
      changeset = Breed.changeset(%{})

      assert errors_on(changeset) == %{name: ["can't be blank"]}
    end

    test "string fields bigger than 255 chars" do
      attrs = params_for(:breed, name: String.duplicate("a", 256))

      changeset = Breed.changeset(attrs)

      assert errors_on(changeset) == %{name: ["should be at most 255 character(s)"]}
    end

    test "name citext unique index" do
      insert(:breed, name: "Gir")
      attrs = params_for(:breed, name: "GIR")

      assert {:error, changeset} = attrs |> Breed.changeset() |> Repo.insert()

      assert errors_on(changeset) == %{
               name: ["has already been taken"]
             }
    end
  end
end
