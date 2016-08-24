# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :hello_phoenix,
  ecto_repos: [HelloPhoenix.Repo]

# Configures the endpoint
config :hello_phoenix, HelloPhoenix.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "AuebEikhkmOJKdljRPfeQzPxi+4WUKCRk9XtcsX/2KRGAvJ8G+D0iU7ARZ2FXlr5",
  render_errors: [view: HelloPhoenix.ErrorView, accepts: ~w(html json)],
  pubsub: [name: HelloPhoenix.PubSub,
           adapter: Phoenix.PubSub.PG2]

config :prometheus, PhoenixInstrumenter,
  labels: [:controller, :action],
  duration_buckets: [10, 100, 1_000, 10_000, 100_000, 300_000]

config :prometheus, PlugsExporter,
  path: "/metrics",
  format: :text,
  registry: :default

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
