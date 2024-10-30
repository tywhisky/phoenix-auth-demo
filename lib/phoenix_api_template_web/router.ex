defmodule PhoenixApiTemplateWeb.Router do
  use PhoenixApiTemplateWeb, :router
  use Plug.ErrorHandler

  def handle_errors(conn, %{reason: %Phoenix.Router.NoRouteError{message: message}}) do
    conn
    |> json(%{errors: message})
    |> halt()
  end

  def handle_errors(conn, %{reason: %{message: message}}) do
    conn
    |> json(%{errors: message})
    |> halt()
  end

  def handle_errors(conn, error) do
    IO.inspect(error)

    conn
    |> json(%{errors: "unknown error"})
    |> halt()
  end

  pipeline :api do
    plug(:accepts, ["json"])
    plug :fetch_session
  end

  pipeline :auth do
    plug PhoenixApiTemplateWeb.Auth.Pipeline
    plug PhoenixApiTemplateWeb.Auth.SetUser
  end

  scope "/api", PhoenixApiTemplateWeb do
    pipe_through(:api)

    get("/", DefaultController, :index)
    post("/register", UserController, :create)
    post("/login", UserController, :sign_in)
  end

  scope "/api", PhoenixApiTemplateWeb do
    pipe_through([:api, :auth])

    get "/users/by_id/:id", UserController, :show
    put "/users/:id", UserController, :update
    get "/user/refresh_session", UserController, :refresh_session
    get "/sign_out", UserController, :sign_out
  end
end
