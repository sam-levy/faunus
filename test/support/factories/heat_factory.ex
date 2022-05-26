defmodule Faunus.Factories.HeatFactory do
  defmacro __using__(_opts \\ []) do
    quote do
      alias Faunus.Heats.Heat

      def heat_factory do
        %Heat{
          detected_at: random_date_between(-90, -1),
          animal: build(:animal)
        }
      end
    end
  end
end
