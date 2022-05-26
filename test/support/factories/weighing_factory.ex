defmodule Faunus.Factories.WeighingFactory do
  defmacro __using__(_opts \\ []) do
    quote do
      alias Faunus.Weighings.Weighing

      def animal_weighing_factory do
        %Weighing{
          measure_in_kg: Faker.random_between(100, 300),
          date: random_date_between(-15, -7),
          animal: build(:animal)
        }
      end
    end
  end
end
