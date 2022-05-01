import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :faunus, Faunus.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "faunus_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :faunus, FaunusWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "wtf5O2c6/now2RDB1aFmUjHMfFOPpMvufR2jg0DSe/hzdFNMyhPSF613XlnEszh8",
  server: false

# In test we don't send emails.
config :faunus, Faunus.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
