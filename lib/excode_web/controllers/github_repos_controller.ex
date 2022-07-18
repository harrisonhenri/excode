defmodule ExcodeWeb.GithubReposController do
  use ExcodeWeb, :controller

  alias Excode.Github.Client, as: ClientGithub
  alias ExcodeWeb.FallbackController

  action_fallback FallbackController

  def index(conn, %{"user" => user}) do
    repos =
      user
      |> ClientGithub.get_repos()
      |> Enum.map(&Map.from_struct/1)

    conn
    |> put_status(:ok)
    |> render("repos.json", repos: repos)
  end
end
