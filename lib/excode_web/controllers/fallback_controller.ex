defmodule ExcodeWeb.FallbackController do
  use ExcodeWeb, :controller

  alias Excode.Error
  alias ExcodeWeb.ErrorView

  def call(conn, {:error, %Error{result: result, status: status}}) do
    conn
    |> put_status(status)
    |> put_view(ErrorView)
    |> render("error.json", result: result)
  end
end
