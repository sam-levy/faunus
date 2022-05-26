defmodule Faunus.Factories.HeatFactory do
  defmacro __using__(_opts \\ []) do
    quote do
      alias Faunus.Animals.Heat

      def heat_factory do
        %Heat{
          detected_at: Faker.Date.between(Faker.Date.backward(90), Faker.Date.backward(1)),
          animal: build(:animal)
        }
      end
    end
  end
end
