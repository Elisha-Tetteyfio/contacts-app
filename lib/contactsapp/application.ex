defmodule Contactsapp.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false
  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Starts a worker by calling: Contactsapp.Worker.start_link(arg)
      # {Contactsapp.Worker, arg}
      Contactsapp.Repo,
      {Plug.Cowboy, scheme: :http, plug: Contactsapp, options: [port: 4002, ip: {10,136,168,7}]}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Contactsapp.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
