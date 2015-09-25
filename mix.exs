defmodule GoogleSheets.Mixfile do
  use Mix.Project

  def project do
    [
      app: :google_sheets,
      version: "1.1.0",
      elixir: "~> 1.0",
      description: description,
      package: package,
      deps: deps,
      name: "GoogleSheets",
      source_url: "https://github.com/GrandCru/GoogleSheets",
      homepage_url: "https://github.com/GrandCru/GoogleSheets",
      docs: [ main: "extra-readme", extras: ["README.md"]]
    ]
  end

  def application do
    [ applications: [:logger, :httpoison, :sweet_xml], mod: { GoogleSheets, [] } ]
  end

  defp description do
    """
    OTP application for fetching and polling Google spreadsheet data in CSV format.
    """
  end

  defp package do
    [
      files: ["lib", "mix.exs", "README.md", "LICENSE"],
      contributors: ["Janne Kaistinen"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/GrandCru/GoogleSheets"}
    ]
  end

  defp deps do
    [
      {:hackney, "~> 1.3"},
      {:httpoison, "~> 0.7"},
      {:sweet_xml, "~> 0.4"},
      {:ex_doc, "~> 0.10", only: [:dev]}
    ]
  end

end
