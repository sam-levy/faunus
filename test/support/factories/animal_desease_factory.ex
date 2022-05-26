defmodule Faunus.Factories.AnimalDeseaseFactory do
  defmacro __using__(_opts \\ []) do
    quote do
      alias Faunus.Animals.AnimalDesease

      def animal_desease_factory do
        %AnimalDesease{
          detected_at: Faker.Date.between(Faker.Date.backward(60), Faker.Date.backward(30)),
          healed_at: Faker.Date.between(Faker.Date.backward(15), Faker.Date.backward(7)),
          animal: build(:animal),
          desease: build(:desease)
        }
      end
    end
  end
end
