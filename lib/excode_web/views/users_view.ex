defmodule ExcodeWeb.UsersView do
  use ExcodeWeb, :view

  def render("create.json", %{user: user}) do
    %{
      user: user
    }
  end
end
