defmodule Contactsapp do
  use Plug.Router
  alias Contactsapp.Controller.Contact
  alias Contactsapp.Controller.Region
  alias Contactsapp.Validation
  alias Contactsapp.Constants

  plug :match
  plug :dispatch

  @moduledoc """
  Documentation for `Contactsapp`.
  """

  get "/" do
    send_resp(conn, 200, "Hello world!!!")
  end

  get "/contacts" do
    case Contact.get_contacts do
      {:ok, contacts} ->
        conn
        |> put_resp_header("content-type", "application/json")
        |> send_resp(200, Poison.encode!(%{resp_code: "00", contacts: contacts}))
      {:error, _message} ->
        conn
        |> put_resp_header("content-type", "application/json")
        |> send_resp(404, Poison.encode!(Constants.no_contacts_found))
    end
  end

  get "/contacts/:id" do
    contact_id = conn.params["id"]
    case Validation.validate_id(contact_id) do
      {:ok, _val} ->
        case Contact.contact_details(contact_id) do
          {:ok, contact} ->
            conn
            |> put_resp_header("content-type", "application/json")
            |> send_resp(200, Poison.encode!(%{resp_code: "00", contact: contact}))
          {:error} ->
            conn
            |> put_resp_header("content-type", "application/json")
            |> send_resp(404, Poison.encode!(Constants.contact_not_found))
        end
      {:error, reason} ->
        conn
        |> put_resp_header("content-type", "application/json")
        |> send_resp(400, Poison.encode!(reason))
    end
  end

  get "/regions" do
    case Region.get_regions do
      {:ok, regions} ->
        conn
        |> put_resp_header("content-type", "application/json")
        |> send_resp(200, Poison.encode!(%{resp_code: "00", regions: regions}))
    end
  end

  post "/contacts" do
    {:ok, body, conn} = read_body(conn)
    {:ok, parsed} = Poison.decode(body)
    with {:ok, fname} <- Validation.validate_first_name(parsed["fname"]),
         {:ok, lname} <- Validation.validate_last_name(parsed["lname"]),
         {:ok, phone} <- Validation.validate_phone_number(parsed["phone"]),
         {:ok, email} <- Validation.validate_email(parsed["email"]),
         {:ok, user_id} <- Validation.validate_body_id(parsed["user_id"]),
         {:ok, suburb_id} <- Validation.validate_body_id(parsed["suburb_id"])
    do
      contact = %{
        fname: fname,
        lname: lname,
        phone: phone,
        user_id: user_id,
        suburb_id: suburb_id,
        email: email
      }

      case Contact.create_contact(contact) do
        {:ok, result} ->
          conn
          |> put_resp_header("content-type", "application/json")
          |> send_resp(201, Poison.encode!(result))
        {:error, reason} ->
          conn
          |> put_resp_header("content-type", "application/json")
          |> send_resp(400, Poison.encode!(reason))
      end
    else
      {:error, reason} ->
        conn
        |> put_status(400)
        |> put_resp_header("content-type", "application/json")
        |> send_resp(400, Poison.encode!(reason))
    end
  end

  put "/contacts/:id" do
    contact_id = conn.params["id"]
    case Validation.validate_id(contact_id) do
      {:ok, _val} ->
        {:ok, body, conn} = read_body(conn)
        {:ok, details} = Poison.decode(body)

        case Contact.update_contact(contact_id, details) do
          {:ok, contact} ->
            conn
            |> put_resp_header("content-type", "application/json")
            |> send_resp(200, Poison.encode!(%{resp_code: "00", contact: contact}))
          {:notfound} ->
            conn
            |> put_resp_header("content-type", "application/json")
            |> send_resp(404, Poison.encode!(Constants.contact_not_found))
        end
      {:error, reason} ->
        conn
        |> put_resp_header("content-type", "application/json")
        |> send_resp(404, Poison.encode!(reason))
    end
  end

  delete "/contacts/:id" do
    contact_id = conn.params["id"]
    case Validation.validate_id(contact_id) do
      {:ok, _val} ->
        case Contact.delete_contact(contact_id) do
          {:ok, _message} ->
            conn
            |> put_resp_header("content-type", "application/json")
            |> send_resp(200, Poison.encode!(%{resp_code: "00", message: "Contact successfully deleted"}))
          {:notfound} ->
            conn
            |> put_resp_header("content-type", "application/json")
            |> send_resp(404, Poison.encode!(Constants.contact_not_found))
        end
      {:error, reason} ->
        conn
        |> put_resp_header("content-type", "application/json")
        |> send_resp(404, Poison.encode!(reason))
    end
  end
end
