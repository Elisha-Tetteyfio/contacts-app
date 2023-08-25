defmodule Contactsapp do
  use Plug.Router
  alias Contactsapp.Controller.Contact

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
end
