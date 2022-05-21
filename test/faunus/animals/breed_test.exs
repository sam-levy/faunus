defmodule Faunus.Animals.BreedTest do
  use Faunus.DataCase, async: true

  alias Faunus.Animals.Breed

  describe "changeset/2" do
    test "valid attrs" do
      attrs = %{name: "Jersey"}

      changeset = Breed.changeset(attrs)

      assert changeset.valid?
      assert changeset.changes == attrs

      assert {:ok, %Breed{}} = Repo.insert(changeset)
    end

    test "invalid attrs" do
      changeset = Breed.changeset(%{name: :invalid})

      refute changeset.valid?
      assert errors_on(changeset) == %{name: ["is invalid"]}
    end

    test "missing required attrs" do
      changeset = Breed.changeset(%{})

      refute changeset.valid?
      assert errors_on(changeset) == %{name: ["can't be blank"]}
    end

    test "string fields bigger than 255 chars" do
      changeset = Breed.changeset(%{name: String.duplicate("a", 256)})

      refute changeset.valid?
      assert errors_on(changeset) == %{name: ["should be at most 255 character(s)"]}
    end
  end
end
