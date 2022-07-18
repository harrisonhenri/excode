defmodule Excode.Github.Client do
  use Tesla

  alias Excode.Error
  alias Excode.GithubRepo
  alias Tesla.Env

  @url_without_user "https://api.github.com/users/#/repos"

  plug Tesla.Middleware.JSON

  def get_repos(url \\ @url_without_user, user) do
    fixed_url = Regex.replace(~r'/#/', url, "/#{user}/")

    fixed_url
    |> get()
    |> handle_get()
  end

  defp handle_get({:ok, %Env{status: 200, body: body}}) do
    Enum.map(body, fn item ->
      GithubRepo.build(item)
    end)
  end

  defp handle_get({:ok, %Env{status: 404}}) do
    {:error, Error.build_user_not_found()}
  end

  defp handle_get({:error, reason}) do
    {:error, Error.build(:bad_request, reason)}
  end
end
