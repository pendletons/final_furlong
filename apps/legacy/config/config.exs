# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :legacy,
  ecto_repos: [Legacy.Repo]

# Configures the endpoint
config :legacy, LegacyWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "QrauPGR1kEnbtFaNLth/k8dSjAtqOwb3xzhqctVF4vaDwi0YzxpxI3S6sVKaF0kq",
  render_errors: [view: LegacyWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Legacy.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Ja Serializer
config :phoenix, :format_encoders,
  "json-api": Poison

# Phauxth authentication configuration
config :phauxth,
  token_salt: "1YmffBpR",
  endpoint: LegacyWeb.Endpoint

config :mime, :types, %{
  "application/vnd.api+json" => ["json-api"]
}

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
