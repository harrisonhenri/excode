# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :excode,
  ecto_repos: [Excode.Repo]

config :excode, Excode.Repo, migration_primary_key: [type: :binary_id]

# Configures the endpoint
config :excode, ExcodeWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: ExcodeWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Excode.PubSub,
  live_view: [signing_salt: "pmHGWKDz"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :tesla, adapter: Tesla.Adapter.Hackney

config :excode, ExcodeWeb.Auth.Guardian,
  issuer: "excode",
  secret_key: "TXXAFr6h/o26LsHDdZWvX3izhZpRzHsHtsqLhfMPwYhHn4Wh7yTySKjHZFc+t9zb"

config :excode, ExcodeWeb.Auth.Pipeline,
  module: ExcodeWeb.Auth.Guardian,
  error_handler: ExcodeWeb.Auth.ErrorHandler

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
