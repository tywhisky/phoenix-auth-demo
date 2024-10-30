defmodule PhoenixApiTemplateWeb.DefaultController do
  use PhoenixApiTemplateWeb, :controller

  def index(conn, _params) do
    text(conn, "It's ALIVE! - #{Mix.env()}")
  end
end
