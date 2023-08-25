defmodule Contactsapp.Schema.Region do
  use Ecto.Schema
  import Ecto.Changeset

  schema "regions" do
    field(:name, :string)
    field(:remark, :string)
    field(:created_at, :utc_datetime, default: DateTime.utc_now() |> DateTime.truncate(:second))
    field(:updated_at, :naive_datetime, default: NaiveDateTime.local_now())
    belongs_to(:user, Contactsapp.Schema.User)
  end

  def changeset(region, attrs) do
    region
    |> cast(attrs, [:name, :user_id])
    |> validate_required([:name, :user_id])
    |> unique_constraint(:name)
  end
end
