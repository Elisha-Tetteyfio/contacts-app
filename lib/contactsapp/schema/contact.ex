defmodule Contactsapp.Schema.Contact do
  use Ecto.Schema
  import Ecto.Changeset

  schema "contacts" do
    field(:fname, :string)
    field(:lname, :string)
    field(:phone, :string)
    field(:birth_date, :utc_datetime)
    field(:email, :string)
    field(:source, :string)
    field(:del_status, :boolean, default: false)
    field(:active_status, :boolean, default: true)
    field(:created_at, :utc_datetime, default: DateTime.utc_now() |> DateTime.truncate(:second))
    field(:updated_at, :naive_datetime, default: NaiveDateTime.local_now())
    belongs_to(:user, Contactsapp.Schema.User)
    belongs_to(:suburb, Contactsapp.Schema.Suburb)
  end

  def changeset(contact, attrs) do
    contact
    |> cast(attrs, [:fname, :lname, :phone, :birth_date, :email, :source, :user_id, :suburb_id, :active_status, :del_status])
    |> validate_required([:fname, :lname, :user_id, :suburb_id])
  end
end
