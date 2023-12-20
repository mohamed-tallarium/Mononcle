defmodule Monocle.MixProject do
  use Mix.Project

  def project do
    [
      app: :monocle,
      version: "0.0.2",
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: description(),
      package: package(),

      # Docs
      name: "Monocle",
      source_url: "https://github.com/mohamed-tallarium/Mononcle",
      docs: [
        # The main page in the docs
        main: "Monocle",
        logo: "monocle.jpg",
        extras: ["README.md"]
      ]
    ]
  end

  defp description() do
    "A library for detecting existing HTML elements on a page or a component in liveview"
  end

  defp package() do
    [
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/mohamed-tallarium/Mononcle"}
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
      {:floki, ">= 0.30.0"},
      {:ex_doc, "~> 0.27", only: :dev, runtime: false}
    ]
  end
end
