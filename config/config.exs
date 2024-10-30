# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :phoenix_api_template,
  ecto_repos: [PhoenixApiTemplate.Repo],
  generators: [binary_id: true]

# Configures the endpoint
config :phoenix_api_template, PhoenixApiTemplateWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: PhoenixApiTemplateWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: PhoenixApiTemplate.PubSub,
  live_view: [signing_salt: "cMVwo6Mm"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Guardian config
config :phoenix_api_template, PhoenixApiTemplateWeb.Auth.Guardian,
  issuer: "phoenix_api_template",
  secret_key: ""

config :guardian, Guardian.DB,
  repo: PhoenixApiTemplate.Repo,
  schema_name: "guardian_tokens",
  sweep_interval: 60

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
