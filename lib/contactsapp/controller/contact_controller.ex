defmodule Contactsapp.Controller.Contact do
  import Ecto.Query

  alias Contactsapp.Validation
  alias Contactsapp.Repo
  alias Contactsapp.Schema.Contact
  alias Contactsapp.Constants

  def get_contacts do
    case Repo.all(
      from(c in Contact,
        where: c.active_status == true and c.del_status == false,
        order_by: [desc: c.created_at],
        select: %{id: c.id, fname: c.fname, lname: c.lname, phone: c.phone, email: c.email, suburb_id: c.suburb_id}
      )
    ) do
      [] ->
        {:error, Constants.no_contacts_found}
      contacts ->
        {:ok, contacts}
    end
  end

  def create_contact(map_) do
    contact = map_
    changeset = Contact.changeset(%Contact{}, contact)

    case Repo.insert(changeset) do
      {:ok, _result} ->
        {:ok, Constants.success_created}

      {:error, reason} ->
        {:error, reason}
    end
  end

  def contact_details(contact_id) do
    case Repo.one(
      from(c in Contact,
        where: c.id == ^contact_id and (c.active_status and not c.del_status),
        order_by: [desc: c.created_at]
        # select: %{id: c.id, fname: c.fname, lname: c.lname, phone: c.phone, email: c.email, birth_date: c.birth_date, suburb_id: c.suburb_id, source: c.source, user_id: c.user_id, active_status: c.active_status, del_status: c.del_status}
      )
    ) do
      nil ->
        {:error, Constants.contact_not_found}

      contact ->
        {:ok, contact}
    end
  end

  def update_contact(contact_id, details) do
    case contact_details(contact_id) do
      {:error, reason} ->
        {:error, reason}
      {:ok, contact} ->
        fname = details["fname"] || contact.fname
        lname = details["lname"] || contact.lname
        phone = details["phone"] || contact.phone
        user_id = contact.user_id
        suburb_id = details["suburb_id"] || contact.suburb_id
        birth_date = details["birth_date"] || contact.birth_date
        email = details["email"] || contact.email

        with  {:ok, fname} <- Validation.validate_first_name(fname),
              {:ok, lname} <- Validation.validate_last_name(lname),
              {:ok, phone} <- Validation.validate_phone_number(phone),
              {:ok, email} <- Validation.validate_email(email),
              {:ok, user_id} <- Validation.validate_body_id(user_id),
              {:ok, suburb_id} <- Validation.validate_body_id(suburb_id)
        do
          new_contact = %{
            fname: fname,
            lname: lname,
            phone: phone,
            user_id: user_id,
            suburb_id: suburb_id,
            birth_date: birth_date,
            email: email
          }

          changed_contact = Contact.changeset(contact, %{active_status: false, del_status: true})
          case Repo.update(changed_contact) do
            {:ok, _result} ->
              case create_contact(new_contact) do
                {:ok, _} ->
                  {:ok, Constants.success_updated}
                {:error, reason} ->
                  {:error, reason}
              end
            {:error, reason} ->
              {:error, reason}
          end
        else
          {:error, reason} ->
            {:error, reason}
        end
    end
  end

  def delete_contact(contact_id) do
    case contact_details(contact_id) do
      {:error, reason} ->
        {:error, reason}
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
