# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :final_furlong,
  ecto_repos: [FinalFurlong.Repo]

# Configures the endpoint
config :final_furlong, FinalFurlongWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "QrauPGR1kEnbtFaNLth/k8dSjAtqOwb3xzhqctVF4vaDwi0YzxpxI3S6sVKaF0kq",
  render_errors: [view: FinalFurlongWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: FinalFurlong.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Phauxth authentication configuration
config :phauxth,
  token_salt: "CZUPdZvR",
  endpoint: FinalFurlongWeb.Endpoint

# Mailer configuration
config :final_furlong, FinalFurlong.Mailer,
  adapter: Bamboo.LocalAdapter


# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
