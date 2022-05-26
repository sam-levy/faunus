defmodule Faunus.Factories.DeseaseFactory do
  defmacro __using__(_opts \\ []) do
    quote do
      alias Faunus.Health.Desease

      def desease_factory do
        %Desease{
          name: Enum.random(deseases())
        }
      end

      def deseases do
        [
          "Mastite",
          "Febre Aftosa",
          "Brucelose",
          "Babesiose",
          "Clostridiose",
          "Tuberculose"
        ]
      end
    end
  end
end
