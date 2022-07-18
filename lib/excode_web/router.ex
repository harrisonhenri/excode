defmodule ExcodeWeb.Router do
  use ExcodeWeb, :router

  alias ExcodeWeb.Auth.Pipeline

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :auth do
    plug Pipeline
  end

  scope "/api", ExcodeWeb do
    pipe_through :api

    post "/users", UsersController, :create
    post "/users/login", AuthController, :create
  end

  scope "/api", ExcodeWeb do
    pipe_through :auth

    get "/repos/:user", GithubReposController, :index
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]

      live_dashboard "/dashboard", metrics: ExcodeWeb.Telemetry
    end
  end
end
