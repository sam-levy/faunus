defmodule Faunus.Factories.AnimalLogFactory do
  defmacro __using__(_opts \\ []) do
    quote do
      alias Faunus.Animals.AnimalLog

      def animal_log_factory do
        %AnimalLog{
          content: Faker.Lorem.sentence(),
          date: Faker.Date.between(Faker.Date.backward(15), Faker.Date.backward(7)),
          animal: build(:animal)
        }
      end
    end
  end
end
