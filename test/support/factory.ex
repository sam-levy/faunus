defmodule Faunus.Factory do
  use ExMachina.Ecto, repo: Faunus.Repo

  use Faunus.Factories.{
    AnimalFactory,
    AnimalDeseaseFactory,
    AnimalMedicationFactory,
    BreedFactory,
    DeseaseFactory,
    HeatFactory,
    LogFactory,
    MedicineFactory,
    OriginFactory,
    WeighingFactory
  }

  defp random_date_between(start, finish) do
    today = Date.utc_today()

    Faker.Date.between(Date.add(today, start), Date.add(today, finish))
  end
end
