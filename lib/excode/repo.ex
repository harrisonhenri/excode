defmodule Excode.Repo do
  use Ecto.Repo,
    otp_app: :excode,
    adapter: Ecto.Adapters.Postgres
end
