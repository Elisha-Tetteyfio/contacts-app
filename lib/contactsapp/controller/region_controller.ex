defmodule Contactsapp.Controller.Region do
  alias Contactsapp.Repo
  alias Contactsapp.Schema.Region

  def get_regions do
    case Repo.all(Region) do
      [] ->
        {:error, %{error: "No regions found"}}

      regions ->
        {:ok, regions}
    end
  end
end
