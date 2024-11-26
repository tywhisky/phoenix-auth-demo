defmodule PhoenixApiTemplateWeb.Auth.Pipeline do
  use Guardian.Plug.Pipeline,
    otp_app: :phoenix_api_template,
    module: PhoenixApiTemplateWeb.Guardian,
    error_handler: PhoenixApiTemplateWeb.GuardianErrorHandler

  plug Guardian.Plug.VerifySession
  plug Guardian.Plug.VerifyHeader
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
