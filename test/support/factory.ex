defmodule Faunus.Factory do
  use ExMachina.Ecto, repo: Faunus.Repo

  use Faunus.Factories.{
    AnimalFactory,
    BreedFactory,
    DeseaseFactory,
    OriginFactory,
    MedicineFactory
  }
end
