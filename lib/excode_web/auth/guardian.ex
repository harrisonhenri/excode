defmodule ExcodeWeb.Auth.Guardian do
  use Guardian, otp_app: :excode

  alias Excode.{Error, User}
  alias Excode.Users.Get

  def subject_for_token(%User{id: id}, _claims), do: {:ok, id}

  def resource_from_claims(claims) do
    claims
    |> Map.get("sub")
    |> Get.call()
  end

  def authenticate(%{"id" => id, "password" => password}) do
    with {:ok, %User{password_hash: hash} = user} <- Get.call(id),
         true <- Pbkdf2.verify_pass(password, hash),
         {:ok, token, _claims} <- encode_and_sign(user) do
      {:ok, token, user}
    else
      false -> {:error, Error.build(:unauthorized, "Please verify your credentials!")}
      error -> error
    end
  end

  def authenticate(_), do: {:error, Error.build(:bad_request, "Invalid or missing params...")}
end
