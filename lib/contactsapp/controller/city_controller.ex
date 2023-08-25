defmodule Contactsapp.Controller.City do
  alias Contactsapp.Repo
  alias Contactsapp.Schema.City

  def get_cities do
    case Repo.all(City) do
      [] ->
        {:error, %{error: "No cities found"}}

      cities ->
        {:ok, cities}
    end
  end
end
