module(..., package.seeall)

local audio = require("audio")

local handles = {
  explosion = { audio.loadSound("audio/explosion.mp3"), 0.5 },
  aggressor = {
    { audio.loadSound("audio/Aggressor - Looped Section1.wav"), 1.0 },
    { audio.loadSound("audio/Aggressor - Looped Section2.wav"), 1.0 },
    { audio.loadSound("audio/Aggressor - Looped Section4.wav"), 1.0 }
  }
}

local config = {
  bgMusic   = { ch = 1 },
  powerUp   = { ch = 2 },
  character = { ch = 3 }
}

local function setVolume(vol, ch)
  audio.setVolume(handles.explosion[2], { channel = ch })
end

function explosion()
  audio.stop(config.character.ch)
  setVolume(handles.explosion[2], config.character.ch)
  audio.play(handles.explosion[1], { channel = config.character.ch })
end

local function startBackgroundMusic(theme)
  local function playBackgroundMusic(event)
    if event == nil or event.completed then
      local sample = theme[math.random(#theme)]
      setVolume(sample[2], config.bgMusic.ch)
      audio.play(sample[1], { channel = config.bgMusic.ch, onComplete = playBackgroundMusic })
    end
  end

  playBackgroundMusic()
end

function stopBackgroundMusic()
  local vol = audio.getVolume(config.bgMusic.ch)
  local t = 5000

  audio.fadeOut({ channel = config.bgMusic.ch, time = t })
  timer.performWithDelay(t, function(e)
    audio.stop(config.bgMusic.ch)
    setVolume(vol, config.bgMusic.ch)
  end)
end

function aggressor()
  startBackgroundMusic(handles.aggressor)
end