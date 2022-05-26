defmodule Faunus.Factories.OriginFactory do
  defmacro __using__(_opts \\ []) do
    quote do
      alias Faunus.Animals.Origin

      def origin_factory do
        %Origin{
          name: sequence("origem")
        }
      end
    end
  end
end
