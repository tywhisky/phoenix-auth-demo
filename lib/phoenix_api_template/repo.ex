defmodule PhoenixApiTemplate.Repo do
  use Ecto.Repo,
    otp_app: :phoenix_api_template,
    adapter: Ecto.Adapters.SQLite3
end
