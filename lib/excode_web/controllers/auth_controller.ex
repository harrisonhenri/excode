defmodule ExcodeWeb.AuthController do
  use ExcodeWeb, :controller

  alias Excode.User
  alias ExcodeWeb.{Auth.Guardian, FallbackController}

  action_fallback FallbackController

  def create(conn, params) do
    with {:ok, token, %User{} = user} <- Guardian.authenticate(params) do
      conn
      |> put_status(:ok)
      |> render("create.json", token: token, user: user)
    end
  end
end
