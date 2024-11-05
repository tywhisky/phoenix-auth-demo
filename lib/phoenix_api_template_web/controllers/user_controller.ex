defmodule PhoenixApiTemplateWeb.UserController do
  use PhoenixApiTemplateWeb, :controller

  alias PhoenixApiTemplateWeb.Auth.ErrorResponse.Unauthorized
  alias PhoenixApiTemplateWeb.Auth.ErrorResponse.Forbidden
  alias PhoenixApiTemplateWeb.Auth.ErrorResponse.NotFound
  alias PhoenixApiTemplateWeb.Auth.Guardian
  alias PhoenixApiTemplate.Accounts
  alias PhoenixApiTemplate.Accounts.User

  plug :is_authorized_user when action in [:update, :delete]

  action_fallback(PhoenixApiTemplateWeb.FallbackController)

  defp is_authorized_user(conn, _options) do
    %{params: %{"id" => id}} = conn
    user = Accounts.get_user!(id)

    if conn.assigns.user.id == user.id do
      conn
    else
      raise Forbidden
    end
  end

  def index(conn, _params) do
    users = Accounts.list_users()
    render(conn, "index.json", users: users)
  end

  def create(conn, %{"user" => user_params}) do
    # {:ok, %Profile{} = _profile} <- Profiles.create_profile(user, profile_params)
    with {:ok, %User{} = user} <- Accounts.create_user(user_params),
         {:ok, token, _claims} <- Guardian.encode_and_sign(user) do
      conn
      |> put_status(:created)
      |> render("user_token.json", user: user, token: token)
    end
  end

  def sign_in(conn, %{"email" => email, "password" => password}) do
    authorize_account(conn, email, password)
  end

  defp authorize_account(conn, email, hash_password) do
    case Guardian.authenticate(email, hash_password) do
      {:ok, user, token, claims} ->
        conn
        |> Plug.Conn.put_session(:user_id, user.id)
        |> put_status(:ok)
        |> render("user_token.json", %{
          user: user,
          token: token,
          expired_at: claims["exp"] * 1_000
        })

      {:error, :unauthorized} ->
        raise Unauthorized, message: "Invalid credentials"
    end
  end

  def sign_out(conn, %{}) do
    user = conn.assigns[:user]
    token = Guardian.Plug.current_token(conn)
    Guardian.revoke(token)

    conn
    |> Plug.Conn.clear_session()
    |> put_status(:ok)
    |> render("user_token.json", %{user: user, token: nil})
  end

  def show(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    render(conn, "show.json", user: user)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Accounts.get_user!(id)

    with {:ok, %User{} = user} <- Accounts.update_user(user, user_params) do
      render(conn, "show.json", user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)

    with {:ok, %User{}} <- Accounts.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end

  def refresh_session(conn, %{}) do
    old_token = Guardian.Plug.current_token(conn)

    case Guardian.decode_and_verify(old_token) do
      {:ok, claims} ->
        case Guardian.resource_from_claims(claims) do
          {:ok, user} ->
            {:ok, _old, {new_token, _new_claims}} = Guardian.refresh(old_token)

            conn
            |> Plug.Conn.put_session(:user_id, user.id)
            |> put_status(:ok)
            |> render("user_token.json", %{user: user, token: new_token})

          {:error, _reason} ->
            raise NotFound
        end

      {:error, _reason} ->
        raise NotFound
    end
  end
end
