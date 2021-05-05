# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :tahmeel,
  ecto_repos: [Tahmeel.Repo]

# Configures the endpoint
config :tahmeel, TahmeelWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "V+3Ee+NhkhsE+RDaSSKnE1T4hrnHT67dU/HHZfxrPgnQka5DuwL2B+enmq3w0OWw",
  render_errors: [view: TahmeelWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Tahmeel.PubSub,
  live_view: [signing_salt: "gIv2Bq3p"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :tahmeel, Tahmeel.Orders.Tasks.Scheduler,
  jobs: [
    gather_orders: [
      schedule: "@midnight",
      task: {Tahmeel.Orders.Tasks.GatherOrders, :run, []}
    ]
  ]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
