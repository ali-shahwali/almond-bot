defmodule Almond do
  use Application
  alias Alchemy.Client


  def start(_type, _args) do
    children = [
      Almond.Scheduler
    ]
    opts = [strategy: :one_for_one, name: Almond.Supervisor]
    Supervisor.start_link(children, opts)
  end



  def start_bot() do
    IO.puts("Hello")
    {:ok, token} = File.read("lib/_deps/_token.txt")
    run = Client.start(token)
    load_modules()
    run
  end


  defp load_modules do
    use Almond.Text
    use Almond.Play
    use Almond.Entertainment
    use Almond.Help
   end
end
