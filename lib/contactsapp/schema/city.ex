defmodule Contactsapp.Schema.City do
  use Ecto.Schema
  import Ecto.Changeset

  schema "cities" do
    field(:name, :string)
    field(:created_at, :utc_datetime, default: DateTime.utc_now() |> DateTime.truncate(:second))
    field(:updated_at, :naive_datetime, default: NaiveDateTime.local_now())
    belongs_to(:users, Contactsapp.Schema.User)
    belongs_to(:regions, Contactsapp.Schema.Region)
  end

  def changeset(city, attrs) do
    city
    |> cast(attrs, [:name, :region_id])
    |> validate_required([:name, :region_id])
    |> unique_constraint(:name)
  end
end
