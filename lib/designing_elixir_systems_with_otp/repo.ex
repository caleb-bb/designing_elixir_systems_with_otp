defmodule DesigningElixirSystemsWithOtp.Repo do
  use Ecto.Repo,
    otp_app: :designing_elixir_systems_with_otp,
    adapter: Ecto.Adapters.Postgres
end
