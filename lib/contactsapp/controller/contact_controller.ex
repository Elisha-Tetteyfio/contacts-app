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

  def create_contact(map_) do
    contact = map_
    changeset = Contact.changeset(%Contact{}, contact)

    case Repo.insert(changeset) do
      {:ok, result} ->
        {:ok, result}

      {:error, reason} ->
        {:error, reason}
    end
  end

  def contact_details(contact_id) do
    case Repo.get_by(Contact, %{
      id: String.to_integer(contact_id)
    }) do
      nil ->
        {:notfound}

      contact ->
        {:ok, contact}
    end
  end

end
