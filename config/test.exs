use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :final_furlong, FinalFurlongWeb.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

config :phauxth,
  log_level: false

# Configure your database
config :final_furlong, FinalFurlong.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: System.get_env("POSTGRES_USER") || "postgres",
  password: System.get_env("POSTGRES_PASSWORD") || "postgres",
  database: "final_furlong_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# Mailer test configuration
config :final_furlong, FinalFurlong.Mailer,
  adapter: Bamboo.TestAdapter
