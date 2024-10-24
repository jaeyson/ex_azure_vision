defmodule ExAzureVision.MixProject do
  use Mix.Project

  @source_url "https://github.com/jaeyson/ex_azure_vision"
  @version "0.1.3"

  def project do
    [
      app: :ex_azure_vision,
      version: @version,
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: "Simple REST wrapper for using Azure's Computer vision",
      docs: docs(),
      package: package(),
      name: "ExAzureVision",
      source_url: @source_url
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :public_key]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
      {:jason, "~> 1.4"},
      {:credo, "~> 1.7", only: [:dev, :test], runtime: false},
      {:ex_doc, "~> 0.34", only: :dev, runtime: false},
      {:req, "~> 0.5"}
    ]
  end

  defp docs do
    [
      api_reference: false,
      main: "readme",
      source_ref: "v#{@version}",
      source_url: @source_url,
      canonical: "http://hexdocs.pm/ex_azure_vision",
      extras: [
        "CHANGELOG.md",
        "LICENSE.md": [title: "License"],
        "README.md": [title: "Overview"]
      ]
    ]
  end

  defp package do
    [
      maintainers: ["Jaeyson Anthony Y."],
      licenses: ["MIT"],
      links: %{
        Github: @source_url,
        Changelog: "https://hexdocs.pm/ex_azure_vision/changelog.html"
      }
    ]
  end
end
