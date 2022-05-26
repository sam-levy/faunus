defmodule Faunus.Health.MedicineTest do
  use Faunus.DataCase, async: true

  alias Faunus.Health.Medicine

  describe "changeset/2" do
    test "valid attrs" do
      attrs = params_for(:medicine)

      changeset = Medicine.changeset(attrs)

      assert changeset.valid?
      assert changeset.changes == attrs

      assert {:ok, %Medicine{}} = Repo.insert(changeset)
    end

    test "missing required attrs" do
      changeset = Medicine.changeset(%{})

      assert errors_on(changeset) == %{name: ["can't be blank"]}
    end

    test "string fields bigger than 255 chars" do
      attrs = params_for(:medicine, name: String.duplicate("a", 256))

      changeset = Medicine.changeset(attrs)

      assert errors_on(changeset) == %{name: ["should be at most 255 character(s)"]}
    end

    test "name citext unique index" do
      insert(:medicine, name: "Adjuvante Assist")
      attrs = params_for(:medicine, name: "ADJUVANTE ASSIST")

      assert {:error, changeset} = attrs |> Medicine.changeset() |> Repo.insert()

      assert errors_on(changeset) == %{
               name: ["has already been taken"]
             }
    end
  end
end
