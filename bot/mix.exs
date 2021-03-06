defmodule Bot.MixProject do
  use Mix.Project

  def project do
    [
      app: :bot,
      version: "0.1.0",
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {Almond, []},
      #applications: [:httpotion]
    ]
  end

  defp deps do
    [
      #{:poison, "~> 4.0.1", override: true},
      {:google_api_you_tube, "~> 0.33"},
      {:jason, "~> 1.2"},
      {:httpotion, "~> 3.1.3"},
      {:tesla, "~> 1.4.0"},
      {:porcelain, "~> 2.0"},
      {:alchemy, "~> 0.6.8", hex: :discord_alchemy},
      {:floki, "~> 0.30.0"},
      #{:crawly, "~> 0.13.0"},
    ]
  end

end
