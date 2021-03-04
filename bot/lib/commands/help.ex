defmodule Almond.Help do
  use Alchemy.Cogs
  require Alchemy.Embed, as: Embed

  Cogs.def help do
    %Embed{title: "commands",
         description:
         "!meme\n !cat\n !play *url*\n !skip & !dc\n
         !mandelbrot *left x-coordinate* *right x-coordinate* *y coordinate* *height* *width* *color-complexity* *color*\n
         Example of 2k green image\n
         !mandelbrot -0.73 -0.67 0.35 2160 1440 512 green"}
        |> Embed.thumbnail("https://i.imgur.com/5CXFHWb.png")
        |> Embed.send()
  end
end
