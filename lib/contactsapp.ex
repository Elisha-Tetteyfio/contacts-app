defmodule Contactsapp do
  use Plug.Router

  plug :match
  plug :dispatch

  @moduledoc """
  Documentation for `Contactsapp`.
  """

  get "/" do
    send_resp(conn, 200, "Hello world!!!")
  end
end
