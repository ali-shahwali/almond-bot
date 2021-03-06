defmodule Almond.Play do
  use Alchemy.Cogs
  alias Alchemy.Cache
  alias Alchemy.Voice

  @doc """
  kind of useless
  """
  Cogs.def connect do
    {:ok, id} = Cogs.guild_id()
    usr = message.author
    {:ok, v_state} = Cache.voice_state(id, usr.id)
    v_id = v_state.channel_id
    Voice.join(id, v_id)
  end

  @doc """
  Disconnects bot from server
  """
  Cogs.def dc do
    {:ok, id} = Cogs.guild_id()
    Voice.leave(id)
  end

  Cogs.set_parser(:play, &List.wrap/1)
  Cogs.def play(url) do
    {:ok, id} = Cogs.guild_id()
    usr = message.author
    {:ok, v_state} = Cache.voice_state(id, usr.id)
    v_id = v_state.channel_id

    spawn(fn -> play_thread(id, v_id, url) end)
  end

  Cogs.set_parser(:p, &List.wrap/1)
  Cogs.def p(keyword) do
    link = get_vid(keyword)
    url = "https://www.youtube.com/watch?v=#{link}"
    Cogs.say "Now playing #{url}"

    {:ok, id} = Cogs.guild_id()
    usr = message.author
    {:ok, v_state} = Cache.voice_state(id, usr.id)
    v_id = v_state.channel_id
    spawn(fn -> play_thread(id, v_id, url)end)
  end

  Cogs.def skip do
    {:ok, id} = Cogs.guild_id()
    spawn(fn -> skip_thread(id) end)
  end

  Cogs.def music do
    {:ok, id} = Cogs.guild_id()
    usr = message.author
    {:ok, v_state} = Cache.voice_state(id, usr.id)
    v_id = v_state.channel_id
    spawn(fn -> music_thread(id, v_id) end)
  end

  defp play_thread(id, v_id, url) do
    Voice.join(id, v_id)
    Voice.play_url(id, url)
  end

  defp skip_thread(id) do
    Voice.stop_audio(id)
  end

  defp music_thread(id, v_id) do
    Voice.join(id, v_id)
    Voice.play_file(id, "lib/_deps/aaeeoo.mp3")
  end

  def get_vid(keyword) do
    {:ok, api_key} = File.read("lib/_deps/youtubeapi.txt")
    %HTTPotion.Response{body: body} =
      HTTPotion.get("https://www.googleapis.com/youtube/v3/search", query: %{key: api_key, part: "snippet", maxResults: 1,q: keyword,type: "video"})

    [_, e|_] = String.split(body,"videoId")
    [e1|_] = String.split(e, "}")
    e1 = String.replace(e1, ~s("), "")
    [_,link] = String.split(e1, ":")
    String.trim(link)
  end
end
