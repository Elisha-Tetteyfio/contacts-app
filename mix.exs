defmodule Contactsapp.MixProject do
  use Mix.Project

  def project do
    [
      app: :contactsapp,
      version: "0.1.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Contactsapp.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"},
      {:cowboy, "~> 2.10"},
      {:ecto, "~> 3.10"},
      {:ecto_sql, "~> 3.10"},
      {:postgrex, "~> 0.17.2"},
      {:plug, "~> 1.14"},
      {:plug_cowboy, "~> 2.6"},
      {:poison, "~> 5.0"},
      {:httpoison, "~> 2.1"}
    ]
  end
end
