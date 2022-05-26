defmodule Faunus.Health.DeseaseTest do
  use Faunus.DataCase, async: true

  alias Faunus.Health.Desease

  describe "changeset/2" do
    test "valid attrs" do
      attrs = params_for(:desease)

      changeset = Desease.changeset(attrs)

      assert changeset.valid?
      assert changeset.changes == attrs

      assert {:ok, %Desease{}} = Repo.insert(changeset)
    end

    test "missing required attrs" do
      changeset = Desease.changeset(%{})

      assert errors_on(changeset) == %{name: ["can't be blank"]}
    end

    test "string fields bigger than 255 chars" do
      attrs = params_for(:desease, name: String.duplicate("a", 256))

      changeset = Desease.changeset(attrs)

      assert errors_on(changeset) == %{name: ["should be at most 255 character(s)"]}
    end

    test "name citext unique index" do
      insert(:desease, name: "Mastite")
      attrs = params_for(:desease, name: "MASTITE")

      assert {:error, changeset} = attrs |> Desease.changeset() |> Repo.insert()

      assert errors_on(changeset) == %{
               name: ["has already been taken"]
             }
    end
  end
end
