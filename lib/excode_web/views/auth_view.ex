defmodule ExcodeWeb.AuthView do
  use ExcodeWeb, :view

  alias Excode.User

  def render("create.json", %{token: token, user: %User{} = user}) do
    %{token: token, user: user}
  end
end
