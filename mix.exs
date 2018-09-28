defmodule ElixirDbf.MixProject do
  use Mix.Project

  def project do
    [
      app: :elixir_dbf,
      version: "0.1.7",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      description: "Small library for DBF parsing written in pure elixir",
      deps: deps(),
      source_url: "https://github.com/nikneroz/elixir_dbf"
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :timex]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:credo, "~> 0.9.1", only: [:dev, :test], runtime: false},
      {:timex, "~> 3.1"},
      {:erlyconv, github: "eugenehr/erlyconv"},
      {:codepagex, "~> 0.1.4"}

      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"},
    ]
  end
end
