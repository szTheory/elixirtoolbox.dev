defmodule Website.MixProject do
  @moduledoc """
  Elixir project specification for ElixirToolbox website
  """

  use Mix.Project

  def project do
    [
      app: :elixirtoolboxwebsite,
      version: "0.1.0",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # http client
      {:tesla, "~> 1.3.0"},
      # html parser
      {:floki, "~> 0.24.0"},
      # markdown parser
      {:earmark, "~> 1.4.3"},
      # linter
      {:credo, "~> 1.1.0", only: [:dev, :test], runtime: false}
    ]
  end
end
