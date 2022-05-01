defmodule Faunus.Repo do
  use Ecto.Repo,
    otp_app: :faunus,
    adapter: Ecto.Adapters.Postgres
end
