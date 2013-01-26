module(..., package.seeall)

local audio = require("audio")

local handles = {
  explosion = audio.loadSound("audio/explosion.mp3"),
  aggressor = {
    audio.loadSound("audio/Aggressor - Looped Section1.wav"),
    audio.loadSound("audio/Aggressor - Looped Section2.wav"),
    audio.loadSound("audio/Aggressor - Looped Section4.wav")
  }
}

local channels = {
  -- don't touch this!
  bgMusic = 1,
  powerUp = 2,
  character = 3
}

function explosion()
  audio.play(handles.explosion)
end

local function startBackgroundMusic(theme)
  local function playBackgroundMusic(event)
    if event == nil or event.completed then
      audio.play(theme[math.random(#theme)], { channel = channels.bgMusic, onComplete = playBackgroundMusic })
    end
  end
  playBackgroundMusic()
end

function aggressor()
  startBackgroundMusic(handles.aggressor)
end

function stopBackgroundMusic()
  local vol = audio.getVolume(channels.bgMusic)
  audio.fadeOut({ channel = channels.bgMusic, time = 1000 })
  audio.stop(channels.bgMusic)
  audio.setVolume(vol, { channel = channels.bgMusic })
end