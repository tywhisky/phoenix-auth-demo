defmodule PhoenixApiTemplateWeb.UserView do
  use PhoenixApiTemplateWeb, :view
  alias PhoenixApiTemplateWeb.UserView

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{
      id: user.id,
      email: user.email,
      hashed_password: user.hashed_password
    }
  end

  def render("user_token.json", %{user: user, token: token}) do
    %{
      id: user.id,
      email: user.email,
      token: token
    }
  end
end
