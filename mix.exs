defmodule Exmorph.Mixfile do
  use Mix.Project

  @version File.read!("VERSION") |> String.strip

  def project do
    [
      app: :exmorph,
      version: @version,
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
    []
  end

  defp package do
    [
      maintainers: ["Michael Matyi"],
      licenses: ["Apache"],
      links: %{"GitHub" => "https://github.com/supernintendo/exmorph"}
    ]
  end
end