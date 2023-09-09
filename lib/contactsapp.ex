defmodule Contactsapp do
  use Plug.Router
  alias Contactsapp.Controller.Contact
  alias Contactsapp.Controller.Region
  alias Contactsapp.Validation

  plug :match
  plug :dispatch

  @moduledoc """
  Documentation for `Contactsapp`.
  """

  def send_response(conn, request_status, response) do
    conn
    |> put_resp_header("content-type", "application/json")
    |> send_resp(request_status, Poison.encode!(response))
  end

  get "/" do
    send_resp(conn, 200, "Hello world!!!")
  end

  get "/contacts" do
    case Contact.get_contacts do
      {:ok, contacts} ->
        send_response(conn, 200, %{resp_code: "00", contacts: contacts})
      {:error, reason} ->
        send_response(conn, 404, reason)
    end
  end

  get "/contacts/:id" do
    contact_id = conn.params["id"]
    case Validation.validate_id(contact_id) do
      {:ok, _val} ->
        case Contact.contact_details(contact_id) do
          {:ok, contact} ->
            send_response(conn, 200, %{resp_code: "00", contact: contact})
          {:error, reason} ->
            send_response(conn, 404, reason)
        end
      {:error, reason} ->
        send_response(conn, 400, reason)
    end
  end

  get "/regions" do
    case Region.get_regions do
      {:ok, regions} ->
        send_response(conn, 200, %{resp_code: "00", regions: regions})
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
        {:ok, message} ->
          send_response(conn, 201, message)
        {:error, reason} ->
          send_response(conn, 400, reason)
      end
    else
      {:error, reason} ->
        send_response(conn, 400, reason)
    end
  end

  put "/contacts/:id" do
    contact_id = conn.params["id"]
    case Validation.validate_id(contact_id) do
      {:ok, _} ->
        {:ok, body, conn} = read_body(conn)
        {:ok, details} = Poison.decode(body)

        case Contact.update_contact(contact_id, details) do
          {:ok, message} ->
            send_response(conn, 200, message)
          {:error, reason} ->
            send_response(conn, 404, reason)
        end
      {:error, reason} ->
        send_response(conn, 400, reason)
    end
  end

  delete "/contacts/:id" do
    contact_id = conn.params["id"]
    case Validation.validate_id(contact_id) do
      {:ok, _} ->
        case Contact.delete_contact(contact_id) do
          {:ok, message} ->
            send_response(conn, 200, message)
          {:error, reason} ->
            send_response(conn, 404, reason)
        end
      {:error, reason} ->
        send_response(conn, 400, reason)
    end
  end
end
