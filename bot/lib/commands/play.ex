defmodule Almond.Play do
  use Alchemy.Cogs
  alias Alchemy.Cache
  alias Alchemy.Voice

  Cogs.def connect do
    {:ok, id} = Cogs.guild_id()
    usr = message.author
    {:ok, v_state} = Cache.voice_state(id, usr.id)
    v_id = v_state.channel_id
    Voice.join(id, v_id)
  end

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
    Voice.join(id, v_id)

    Voice.play_url(id, url)
  end
  Cogs.def play(vidname) do

  end

  Cogs.def skip do
    {:ok, id} = Cogs.guild_id()
    Voice.stop_audio(id)
  end

  Cogs.def music do
    {:ok, id} = Cogs.guild_id()
    usr = message.author
    {:ok, v_state} = Cache.voice_state(id, usr.id)
    v_id = v_state.channel_id
    Voice.join(id, v_id)

    Voice.play_file(id, "lib/_deps/aaeeoo.mp3")
  end

end
