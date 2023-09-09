defmodule Contactsapp.Controller.User do
  alias Contactsapp.Repo
  alias Contactsapp.Schema.User

  def get_users do
    case Repo.all(User) do
      [] ->
        {:error, %{error: "No users found"}}

      users ->
        {:ok, users}
    end
  end
end
