defmodule Faunus.Factory do
  use ExMachina.Ecto, repo: Faunus.Repo

  use Faunus.Factories.{
    AnimalFactory,
    AnimalDeseaseFactory,
    AnimalLogFactory,
    AnimalMedicationFactory,
    AnimalWeighingFactory,
    BreedFactory,
    DeseaseFactory,
    OriginFactory,
    MedicineFactory
  }
end
