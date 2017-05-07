defmodule Exmorph.Mixfile do
  use Mix.Project

  def project do
    [
      app: :exmorph,
      version: "1.0.0",
      elixir: "~> 1.4.0",
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      description: "Use Elixir maps as a document storage format.",
      deps: deps(),
      package: package()
   ]
  end

  def application do
    []
  end

  defp deps do
    [
      {:earmark, ">= 0.0.0", only: :dev},
      {:ex_doc, "~> 0.10", only: :dev}
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
