defmodule Contactsapp.Repo do
  use Ecto.Repo,
    otp_app: :contactsapp,
    adapter: Ecto.Adapters.Postgres
end
