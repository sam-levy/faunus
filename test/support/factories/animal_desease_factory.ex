defmodule Faunus.Factories.AnimalDeseaseFactory do
  defmacro __using__(_opts \\ []) do
    quote do
      alias Faunus.Animals.AnimalDesease

      def animal_desease_factory do
        %AnimalDesease{
          detected_at: random_date_between(-60, -30),
          healed_at: random_date_between(-15, -7),
          animal: build(:animal),
          desease: build(:desease)
        }
      end
    end
  end
end
