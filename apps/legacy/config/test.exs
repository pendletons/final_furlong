use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :legacy, LegacyWeb.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :legacy, Legacy.Repo,
  adapter: Ecto.Adapters.MySQL,
  username: "mysql",
  password: "mysql",
  database: "final_furlong_legacy_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# Mailer test configuration
config :legacy, Legacy.Mailer,
  adapter: Bamboo.TestAdapter
