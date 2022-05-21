defmodule Faunus.Health.MedicineTest do
  use Faunus.DataCase, async: true

  alias Faunus.Health.Medicine

  describe "changeset/2" do
    test "valid attrs" do
      attrs = %{name: "Ivomec"}

      changeset = Medicine.changeset(attrs)

      assert changeset.valid?
      assert changeset.changes == attrs

      assert {:ok, %Medicine{}} = Repo.insert(changeset)
    end

    test "invalid attrs" do
      changeset = Medicine.changeset(%{name: :invalid})

      refute changeset.valid?
      assert errors_on(changeset) == %{name: ["is invalid"]}
    end

    test "missing required attrs" do
      changeset = Medicine.changeset(%{})

      refute changeset.valid?
      assert errors_on(changeset) == %{name: ["can't be blank"]}
    end

    test "string fields bigger than 255 chars" do
      changeset = Medicine.changeset(%{name: String.duplicate("a", 256)})

      refute changeset.valid?
      assert errors_on(changeset) == %{name: ["should be at most 255 character(s)"]}
    end
  end
end
