defmodule Faunus.Factories.OriginFactory do
  defmacro __using__(_opts \\ []) do
    quote do
      alias Faunus.Origins.Origin

      def origin_factory do
        %Origin{
          name: sequence("origem")
        }
      end
    end
  end
end
