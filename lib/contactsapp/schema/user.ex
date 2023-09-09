defmodule Contactsapp.Schema.User do
  use Ecto.Schema

  schema "users" do
    field(:fname, :string)
    field(:lname, :string)
    field(:phone, :string)
    field(:birth_date, :utc_datetime)
    field(:email, :string)
    field(:del_status, :boolean, default: false)
    field(:active_status, :boolean, default: true)
    field(:created_at, :utc_datetime, default: DateTime.utc_now() |> DateTime.truncate(:second))
    field(:updated_at, :naive_datetime, default: NaiveDateTime.local_now())
    field(:encrypted_password, :string)
    field(:reset_password_token, :string)
    field(:reset_password_sent_at, :string)
    field(:remember_created_at, :string)
  end
end
