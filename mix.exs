defmodule Exmorph.Mixfile do
  use Mix.Project

  def project do
    [
      app: :exmorph,
      version: "1.1.1",
      elixir: "~> 1.4.0",
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      description: "A simple tweening and data transformation library for Elixir",
      deps: deps(),
      package: package(),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        "coveralls": :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test
      ]
   ]
  end

  def application do
    []
  end

  defp deps do
    [
      {:earmark, ">= 0.0.0", only: :dev},
      {:ex_doc, "~> 0.10", only: :dev},
      {:excoveralls, "~> 0.6", only: :test}
    ]
  end

  defp package do
    [
      maintainers: ["Michael Matyi"],
      licenses: ["Apache"],
      links: %{"GitHub" => "https://github.com/supernintendo/exmorph"}
    ]
  end
end
