defmodule ExcodeWeb.UsersController do
  use ExcodeWeb, :controller

  alias Excode.User
  alias Excode.Users.Create
  alias ExcodeWeb.FallbackController

  action_fallback(FallbackController)

  def create(conn, params) do
    with {:ok, %User{} = user} <- Create.call(params) do
      conn
      |> put_status(:created)
      |> render("create.json", user: user)
    end
  end
end
