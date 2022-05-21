defmodule Faunus.Animals.OriginTest do
  use Faunus.DataCase, async: true

  alias Faunus.Animals.Origin

  describe "changeset/2" do
    test "valid attrs" do
      attrs = %{name: "Fazenda Barro Branco"}

      changeset = Origin.changeset(attrs)

      assert changeset.valid?
      assert changeset.changes == attrs

      assert {:ok, %Origin{}} = Repo.insert(changeset)
    end

    test "invalid attrs" do
      changeset = Origin.changeset(%{name: :invalid})

      refute changeset.valid?
      assert errors_on(changeset) == %{name: ["is invalid"]}
    end

    test "missing required attrs" do
      changeset = Origin.changeset(%{})

      refute changeset.valid?
      assert errors_on(changeset) == %{name: ["can't be blank"]}
    end

    test "string fields bigger than 255 chars" do
      changeset = Origin.changeset(%{name: String.duplicate("a", 256)})

      refute changeset.valid?
      assert errors_on(changeset) == %{name: ["should be at most 255 character(s)"]}
    end
  end
end
