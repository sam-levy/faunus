defmodule Faunus.Factories.AnimalMedicationFactory do
  defmacro __using__(_opts \\ []) do
    quote do
      alias Faunus.Animals.AnimalMedication

      def animal_medication_factory do
        %AnimalMedication{
          dose: Faker.random_between(1, 20),
          given_at: random_date_between(-15, -7),
          animal: build(:animal),
          medicine: build(:medicine)
        }
      end
    end
  end
end
