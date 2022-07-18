defmodule Excode.Users.Get do
  alias Excode.{Error, Repo, User}

  def call(id) do
    case Repo.get(User, id) do
      %User{} = user -> {:ok, user}
      nil -> {:error, Error.build_user_not_found()}
    end
  end
end
