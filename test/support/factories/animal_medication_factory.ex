defmodule Faunus.Factories.AnimalMedicationFactory do
  defmacro __using__(_opts \\ []) do
    quote do
      alias Faunus.Animals.AnimalMedication

      def animal_medication_factory do
        %AnimalMedication{
          dose: Faker.random_between(1, 20),
          given_at: Faker.Date.between(Faker.Date.backward(15), Faker.Date.backward(7)),
          animal: build(:animal),
          medicine: build(:medicine)
        }
      end
    end
  end
end
