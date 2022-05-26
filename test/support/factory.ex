defmodule Faunus.Factory do
  use ExMachina.Ecto, repo: Faunus.Repo

  use Faunus.Factories.{
    AnimalFactory,
    AnimalDeseaseFactory,
    AnimalMedicationFactory,
    BreedFactory,
    DeseaseFactory,
    OriginFactory,
    MedicineFactory
  }
end
