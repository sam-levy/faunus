defmodule Faunus.Origins.OriginTest do
  use Faunus.DataCase, async: true

  alias Faunus.Origins.Origin

  describe "changeset/2" do
    test "valid attrs" do
      attrs = params_for(:origin)

      changeset = Origin.changeset(attrs)

      assert changeset.valid?
      assert changeset.changes == attrs

      assert {:ok, %Origin{}} = Repo.insert(changeset)
    end

    test "missing required attrs" do
      changeset = Origin.changeset(%{})

      assert errors_on(changeset) == %{name: ["can't be blank"]}
    end

    test "string fields bigger than 255 chars" do
      attrs = params_for(:origin, name: String.duplicate("a", 256))

      changeset = Origin.changeset(attrs)

      assert errors_on(changeset) == %{name: ["should be at most 255 character(s)"]}
    end

    test "name citext unique index" do
      insert(:origin, name: "Fazenda Barro Branco")
      attrs = params_for(:origin, name: "FAZENDA BARRO BRANCO")

      assert {:error, changeset} = attrs |> Origin.changeset() |> Repo.insert()

      assert errors_on(changeset) == %{
               name: ["has already been taken"]
             }
    end
  end
end
