defmodule Almond.Entertainment do
  use Alchemy.Cogs
  alias Alchemy.Client

  Cogs.def meme do
    c_id = message.channel_id
    n = Enum.random(1..50)
    case Client.send_message(c_id, "", file: "lib/_deps/#{n}.png") do
      {:ok, _} ->
        :ok
      _ ->
        case Client.send_message(c_id, "", file: "lib/_deps/#{n}.jpg") do
          {:ok, _} ->
            :ok
          _ ->
            Client.send_message(c_id, "", file: "lib/_deps/#{n}.mp4")
        end
    end
  end

  Cogs.def sigmoid do
    c_id = message.channel_id
    Client.send_message(c_id, "", file: "lib/_deps/sigmoid.png")
  end

  Cogs.def tenta do
    c_id = message.channel_id
    Client.send_message(c_id, "", file: "lib/_deps/tenta.mp4")
  end

  Cogs.def cat do
    c_id = message.channel_id
    n = Enum.random(1..36)
    case Client.send_message(c_id, "", file: "lib/_deps/cats/#{n}.png") do
      {:ok, _} ->
        :ok
      _ ->
        Client.send_message(c_id, "", file: "lib/_deps/cats/#{n}.jpg")
      end
  end

  Cogs.set_parser(:mandelbrot, &List.wrap/1)
  Cogs.def mandelbrot(options) do
    [width, height, color | _] = String.split(options)
    {w, _} = Integer.parse(width)
    {h, _} = Integer.parse(height)
    Mainbrot.test(w, h, color)
    c_id = message.channel_id
    Client.send_message(c_id, "", file: "mandelbrot.png")
  end

end
