defmodule Contactsapp.Controller.Contact do
  alias Contactsapp.Repo
  alias Contactsapp.Schema.Contact

  def get_contacts do
    case Repo.all(Contact) do
      # [] ->
      #   {:error, %{error: "No contacts found"}}

      [] ->
        {:ok, %{msg: "No contacts found"}}

      contacts ->
        {:ok, contacts}
    end
  end
end
