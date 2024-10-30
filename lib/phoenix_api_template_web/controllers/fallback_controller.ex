defmodule PhoenixApiTemplateWeb.FallbackController do
  @moduledoc """
  Translates controller action results into valid `Plug.Conn` responses.

  See `Phoenix.Controller.action_fallback/1` for more details.
  """
  use PhoenixApiTemplateWeb, :controller

  # This clause handles errors returned by Ecto's insert/update/delete.
  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(PhoenixApiTemplateWeb.ChangesetView)
    |> render("error.json", changeset: changeset)
  end

  # This clause is an example of how to handle resources that cannot be found.
  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(PhoenixApiTemplateWeb.ErrorView)
    |> render(:"404")
  end

  # 添加以下模式匹配处理 `:secret_not_found` 错误
  def call(conn, {:error, :secret_not_found}) do
    conn
    |> put_status(:not_found)
    |> json(%{error: "Secret not found"})
  end
end
