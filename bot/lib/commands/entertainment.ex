defmodule Almond.Entertainment do
  use Alchemy.Cogs
  alias Alchemy.Client

  Cogs.def meme do
    c_id = message.channel_id
    img = rand_file("lib/media")
    Client.send_message(c_id, "", file: "lib/media/#{img}")
  end

  Cogs.def upload do
    [atch] = message.attachments
    url = atch.proxy_url

    split1 = String.split(url, "/")
    split2 = String.split(List.last(split1), ".")
    file_type = List.last(split2)
    %HTTPoison.Response{body: body} = HTTPoison.get!(url)
    n = folder_size("lib/media")
    File.write!("lib/media/#{n}.#{file_type}", body)
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
    img = rand_file("lib/_deps/cats")
    Client.send_message(c_id, "", file: "lib/_deps/cats/#{img}")
  end

  Cogs.set_parser(:mandelbrot, &List.wrap/1)
  Cogs.def mandelbrot(options) do
    [x0, xn, y0, width, height, depth, color | _] = String.split(options)
    {w, _} = Integer.parse(width)
    {h, _} = Integer.parse(height)
    {d, _} = Integer.parse(depth)
    {y, _} = Float.parse(y0)
    {x1, _} = Float.parse(x0)
    {x2, _} = Float.parse(xn)

    Mainbrot.test(x1, x2, y, w, h, d, color)
    c_id = message.channel_id
    Client.send_message(c_id, "", file: "mandelbrot.png")
  end

  Cogs.def watch(url) do
    Cogs.say get_http(url)
  end

  defp rand_file(path) do
    {:ok, files} = File.ls(path)
    Enum.random(files)
  end

  defp folder_size(path) do
    {:ok, files} = File.ls(path)
    Kernel.length(files)
  end

  defp get_http(url) do
    HTTPotion.start()
    {:ok, key} = File.read("lib/_deps/w2g.txt")
    json_body =
      Jason.encode!(%{"w2g_api_key" => key, "share" => url, "bg_color" => "#000000", "bg_opacity" => "100"})
    %HTTPotion.Response{body: str} = HTTPotion.post("https://w2g.tv/rooms/create.json", [headers: ["Accept": "application/json", "Content-Type": "application/json"], body: json_body])
    str = String.split(str, ",")
    [_, e|_] = str
    e = String.split(e, ":")
    [_, e1|_] = e
    e1 = String.replace(e1, ~s("), "")
    "https://w2g.tv/rooms/#{e1}"
  end
end
