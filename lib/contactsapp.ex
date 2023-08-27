defmodule Contactsapp do
  use Plug.Router
  alias Contactsapp.Controller.Contact
  alias Contactsapp.Controller.Region

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
    case Poison.decode(body) do
      {:ok, parsed} ->
        case Contact.create_contact(parsed) do
          {:ok, result} ->
            IO.inspect(result)

            conn
            |> put_status(201)
            |> put_resp_header("content-type", "application/json")
            |> send_resp(201, Poison.encode!(result))

          {:error, reason} ->
            conn
            |> put_status(400)
            |> put_resp_header("content-type", "application/json")
            |> send_resp(400, Poison.encode!(reason))
        end
      {:error, reason} ->
        IO.inspect(reason)
        conn
        |> put_status(400)
        |> put_resp_header("content-type", "application/json")
        |> send_resp(400, Poison.encode!(reason))
      end
    end
  end
