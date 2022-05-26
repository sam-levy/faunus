defmodule Faunus.Factories.LogFactory do
  defmacro __using__(_opts \\ []) do
    quote do
      alias Faunus.Logs.Log

      def animal_log_factory do
        %Log{
          content: Faker.Lorem.sentence(),
          date: random_date_between(-15, -7),
          animal: build(:animal)
        }
      end
    end
  end
end
