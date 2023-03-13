defmodule Medians.Repo do
  use Ecto.Repo,
    otp_app: :medians,
    adapter: Ecto.Adapters.Postgres
end
