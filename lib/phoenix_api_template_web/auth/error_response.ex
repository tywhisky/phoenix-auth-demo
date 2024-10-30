defmodule PhoenixApiTemplateWeb.Auth.ErrorResponse.Unauthorized do
  defexception message: "Unauthorized", plug_status: 401
end

defmodule PhoenixApiTemplateWeb.Auth.ErrorResponse.Forbidden do
  defexception message: "Forbidden", plug_status: 403
end

defmodule PhoenixApiTemplateWeb.Auth.ErrorResponse.NotFound do
  defexception message: "Not Found", plug_status: 404
end
