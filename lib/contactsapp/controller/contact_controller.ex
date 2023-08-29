defmodule Contactsapp.Controller.Contact do
  import Ecto.Query

  alias Contactsapp.Repo
  alias Contactsapp.Schema.Contact

  def get_contacts do
    case Repo.all(
      from(c in Contact,
        where: c.active_status == true and c.del_status == false,
        order_by: [desc: c.created_at],
        select: %{id: c.id, fname: c.fname, lname: c.lname, phone: c.phone, email: c.email, suburb_id: c.suburb_id}
      )
    ) do
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
      id: contact_id, active_status: true, del_status: false
    }) do
      nil ->
        {:notfound}

      contact ->
        {:ok, contact}
    end
  end

  def update_contact(contact_id, details) do
    case contact_details(contact_id) do
      {:notfound} ->
        {:notfound}
      {:ok, contact} ->
        changed_contact = Contact.changeset(contact, %{active_status: false, del_status: true})
        IO.inspect(changed_contact)

        case Repo.update(changed_contact) do
          {:ok, _result} ->
            new_contact = %{
              fname: details["fname"] || contact.fname,
              lname: details["lname"] || contact.lname,
              phone: details["phone"] || contact.phone,
              user_id: contact.user_id,
              suburb_id: details["suburb_id"] || contact.suburb_id,
              birth_date: details["birth_date"] || contact.birth_date,
              email: details["email"] || contact.email
            }

            case create_contact(new_contact) do
              {:ok, contact} ->
                {:ok, contact}
              {:error, reason} ->
                {:error, reason}
            end
          {:error, reason} ->
            {:error, reason}
        end
    end
  end

  def delete_contact(contact_id) do
    case contact_details(contact_id) do
      {:notfound} ->
        {:notfound}
      {:ok, contact} ->
        changed_contact = Contact.changeset(contact, %{active_status: false, del_status: true})

        case Repo.update(changed_contact) do
          {:ok, _result} ->
            {:ok, %{message: "Contact successfully deleted"}}
          {:error, reason} ->
            {:error, reason}
        end
    end
  end

end
