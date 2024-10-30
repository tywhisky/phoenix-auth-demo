defmodule PhoenixApiTemplateWeb.Auth.Pipeline do
  use Guardian.Plug.Pipeline,
    otp_app: :phoenix_api_template,
    module: PhoenixApiTemplateWeb.Auth.Guardian,
    error_handler: PhoenixApiTemplateWeb.Auth.GuardianErrorHandler

  plug Guardian.Plug.VerifySession
  plug Guardian.Plug.VerifyHeader
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
