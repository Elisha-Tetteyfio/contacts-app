defmodule Contactsapp.Schema.Suburb do
  use Ecto.Schema
  import Ecto.Changeset

  schema "suburbs" do
    field(:name, :string)
    field(:created_at, :utc_datetime, default: DateTime.utc_now() |> DateTime.truncate(:second))
    field(:updated_at, :naive_datetime, default: NaiveDateTime.local_now())
    belongs_to(:users, Contactsapp.Schema.User)
    belongs_to(:cities, Contactsapp.Schema.City)
  end

  def changeset(suburb, attrs) do
    suburb
    |> cast(attrs, [:name, :city_id])
    |> validate_required([:name, :city_id])
    |> unique_constraint(:name)
  end
end
