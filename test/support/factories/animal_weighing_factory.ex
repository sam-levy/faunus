defmodule Faunus.Factories.AnimalWeighingFactory do
  defmacro __using__(_opts \\ []) do
    quote do
      alias Faunus.Animals.AnimalWeighing

      def animal_weighing_factory do
        %AnimalWeighing{
          measure_in_kg: Faker.random_between(100, 300),
          date: Faker.Date.between(Faker.Date.backward(15), Faker.Date.backward(7)),
          animal: build(:animal)
        }
      end
    end
  end
end
