defmodule Contactsapp.Controller.Suburb do
  alias Contactsapp.Repo
  alias Contactsapp.Schema.Suburb

  def get_suburbs do
    case Repo.all(Suburb) do
      [] ->
        {:error, %{error: "No suburbs found"}}

      suburbs ->
        {:ok, suburbs}
    end
  end
end
