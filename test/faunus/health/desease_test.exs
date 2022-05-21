defmodule Faunus.Health.DeseaseTest do
  use Faunus.DataCase, async: true

  alias Faunus.Health.Desease

  describe "changeset/2" do
    test "valid attrs" do
      attrs = %{name: "Brucelose"}

      changeset = Desease.changeset(attrs)

      assert changeset.valid?
      assert changeset.changes == attrs

      assert {:ok, %Desease{}} = Repo.insert(changeset)
    end

    test "invalid attrs" do
      changeset = Desease.changeset(%{name: :invalid})

      refute changeset.valid?
      assert errors_on(changeset) == %{name: ["is invalid"]}
    end

    test "missing required attrs" do
      changeset = Desease.changeset(%{})

      refute changeset.valid?
      assert errors_on(changeset) == %{name: ["can't be blank"]}
    end

    test "string fields bigger than 255 chars" do
      changeset = Desease.changeset(%{name: String.duplicate("a", 256)})

      refute changeset.valid?
      assert errors_on(changeset) == %{name: ["should be at most 255 character(s)"]}
    end
  end
end
