defmodule PhoenixApiTemplateWeb.Auth.SetUser do
  import Plug.Conn
  alias PhoenixApiTemplateWeb.Auth.ErrorResponse
  alias PhoenixApiTemplate.Accounts

  def init(_options) do
  end

  def call(conn, _options) do
    if conn.assigns[:user] do
      conn
    else
      user_id = get_session(conn, :user_id)

      if user_id == nil do
        raise ErrorResponse.Unauthorized
      end

      user = Accounts.get_user!(user_id)

      cond do
        user_id && user -> assign(conn, :user, user)
        true -> assign(conn, :user, nil)
      end
    end
  end
end
