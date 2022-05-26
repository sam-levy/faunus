defmodule Faunus.Factories.BreedFactory do
  defmacro __using__(_opts \\ []) do
    quote do
      alias Faunus.Breeds.Breed

      def breed_factory do
        %Breed{
          name: sequence("raça")
        }
      end
    end
  end
end
