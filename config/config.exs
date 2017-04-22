# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :phoenix_server,
  ecto_repos: [PhoenixServer.Repo]

# Configures the endpoint
config :phoenix_server, PhoenixServer.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "fY22+U7UpacyGAE6/Zqv9rpv/gKxEgnK8ecuIjVCM2eqCgx8NkBQI7ocskiO0T5p",
  render_errors: [view: PhoenixServer.ErrorView, accepts: ~w(html json)],
  pubsub: [name: PhoenixServer.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
