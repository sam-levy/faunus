defmodule Faunus.Factories.AnimalFactory do
  defmacro __using__(_opts \\ []) do
    quote do
      alias Faunus.Animals.Animal

      def animal_factory do
        %Animal{
          name: Faker.Dog.PtBr.name(),
          gender: Enum.random([:male, :female]),
          is_currently_owned: true,
          internal_code: Faker.Code.iban() |> String.slice(0..6),
          birth_date: random_date_between(-600, -2000),
          breed: build(:breed),
          origin: build(:origin)
        }
      end
    end
  end
end
