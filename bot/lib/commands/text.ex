defmodule Almond.Text do
  use Alchemy.Cogs
  alias Alchemy.Client


  Cogs.set_parser(:sentient, &List.wrap/1)
  Cogs.def sentient(rest) do
    Client.delete_message(message)
    Cogs.say rest
  end

end
