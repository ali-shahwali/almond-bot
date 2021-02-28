use Mix.Config

config :porcelain, driver: Porcelain.Driver.Basic

config :alchemy,
  ffmpeg_path: "lib/_deps/ffmpeg/bin/ffmpeg.exe",
  youtube_dl_path: "lib/_deps/youtube-dl/youtube-dl.exe"
