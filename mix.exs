defmodule Cesar2.MixProject do
  use Mix.Project

  def project do
    [
      app: :cesar2,
      version: "0.1.0",
      elixir: "~> 1.9",
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env() == :prod,
      escript: escript_config(),
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
      {:credo,     "~> 1.1.0", only: [:dev, :test], runtime: false},
      {:dialyxir,  "~> 1.0.0-rc.6", only: [:dev, :test], runtime: false},
      {:propcheck, "~> 1.1", only: [:test, :dev]}
    ]
  end

  defp escript_config do
    [ main_module: Client ]
  end
end
