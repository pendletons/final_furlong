# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :master_proxy,
  namespace: MasterProxy,
  ecto_repos: []

# Configures the endpoint
config :master_proxy, MasterProxy.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "uZCJAT4eCAs+FjoMSvpD5QIsCMmpAKFQI1mD+gVJ9AfHBnuwh/lpmBtz1+QjY2ib",
  render_errors: [view: MasterProxy.ErrorView, accepts: ~w(json)],
  pubsub: [name: MasterProxy.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :master_proxy, :generators,
  context_app: false

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
# import_config "#{Mix.env}.exs"
