defmodule Faunus.Factories.DeseaseFactory do
  defmacro __using__(_opts \\ []) do
    quote do
      alias Faunus.Health.Desease

      def desease_factory do
        %Desease{
          name: sequence("doença")
        }
      end
    end
  end
end
