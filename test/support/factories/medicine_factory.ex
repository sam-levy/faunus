defmodule Faunus.Factories.MedicineFactory do
  defmacro __using__(_opts \\ []) do
    quote do
      alias Faunus.Health.Medicine

      def medicine_factory do
        %Medicine{
          name: Faker.Pokemon.name()
        }
      end
    end
  end
end
