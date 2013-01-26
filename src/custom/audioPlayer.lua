module(..., package.seeall)

local audio = require("audio")

local handles = {
  explosion     = { audio.loadSound("audio/explosion.mp3"),     0.25 },
  death         = { audio.loadSound("audio/dogpoop_die.mp3"),   0.75 },
  defibrillator = { audio.loadSound("audio/defibrillator.mp3"), 0.75 },
  flatline      = { audio.loadSound("audio/flatline.mp3"),      0.75 },
  jump          = { audio.loadSound("audio/jump.mp3"),          1.0 },
  boost         = { audio.loadSound("audio/boost.mp3"),         1.0 },
  brickStone    = { audio.loadSound("audio/brick_stone.mp3"),   1.0 },
  cardboardBox  = { audio.loadSound("audio/cardboard_box.mp3"), 1.0 },
  carCrash      = { audio.loadSound("audio/car_crash.mp3"),     1.0 },
  powerDown     = { audio.loadSound("audio/powerdown.mp3"),     1.0 },
  powerUp       = { audio.loadSound("audio/powerup.mp3"),       1.0 },
  stoneBreak    = { audio.loadSound("audio/stone_break.mp3"),   1.0 },
  trashcanA     = { audio.loadSound("audio/trashcan_a.mp3"),    1.0 },
  trashcanB     = { audio.loadSound("audio/trashcan_b.mp3"),    1.0 },
  woodBox       = { audio.loadSound("audio/wood_box.mp3"),      1.0 },
  woodBreak     = { audio.loadSound("audio/wood_break.mp3"),    1.0 },


  heartbeat = { audio.loadSound("audio/heartbeat.mp3"),         1.0 },
  aggressor = {
    { audio.loadSound("audio/music_loop_1.mp3"),                0.01 },
    { audio.loadSound("audio/music_loop_2.mp3"),                0.01 },
    { audio.loadSound("audio/music_loop_3.mp3"),                0.01 }
  }
}

local config = {
  bgMusic   = { ch = 1, src = nil, pitch = 0.9 },
  bgHeart   = { ch = 2, src = nil }, -- shares pitch w/ bgMusic
  powerUp   = { ch = 3 },
  character = { ch = 4 },
  atmo      = { ch = 5 }
}

local function setVolume(vol, ch)
  audio.setVolume(handles.explosion[2], { channel=ch })
end

local function sfx(sample, cfg)
  audio.stop(cfg.ch)
  setVolume(sample[2], cfg.ch)
  audio.play(sample[1], { channel=cfg.ch })
end

local function startBackgroundMusic(theme)
  local function playBackgroundMusic(event)
    if event == nil then
      config.bgMusic.pitch = 0.9
    end
    if event == nil or event.completed then
      local sample = theme[math.random(#theme)]
      setVolume(sample[2], config.bgMusic.ch)
      _, config.bgMusic.src = audio.play(sample[1], { channel=config.bgMusic.ch, onComplete = playBackgroundMusic })

      if config.bgMusic.pitch < 1.5 and math.random(100) > 25 then
        config.bgMusic.pitch = config.bgMusic.pitch + 0.1
        if config.bgMusic.src ~= nil and config.bgHeart.src ~= nil then
          al.Source(config.bgMusic.src, al.PITCH, config.bgMusic.pitch)
          al.Source(config.bgHeart.src, al.PITCH, config.bgMusic.pitch)
        end
      end
    end
  end
  local function playHeartbeat(event)
    if event == nil or event.completed then
      setVolume(handles.heartbeat[2], config.bgHeart.ch)
      _, config.bgHeart.src = audio.play(handles.heartbeat[1], { channel=config.bgHeart.ch, onComplete=playHeartbeat })
    end
  end

  playHeartbeat()
  playBackgroundMusic()
end


--==============================================================================
-- public API
--==============================================================================

function stopBackgroundMusic()
  local vol = audio.getVolume(config.bgMusic.ch)
  local t = 2000

  audio.fadeOut({ channel=config.bgMusic.ch, time=t })
  audio.fadeOut({ channel=config.bgHeart.ch, time=t })

  timer.performWithDelay(t+200, function(e)
    audio.stop(config.bgMusic.ch)
    audio.stop(config.bgHeart.ch)
    setVolume(vol, config.bgMusic.ch)
    setVolume(vol, config.bgHeart.ch)
  end)
end

function aggressor()
  startBackgroundMusic(handles.aggressor)
end

function explosion()
  sfx(handles.explosion, config.character)
end

function death()
  sfx(handles.death, config.character)
end

function defibrillator()
  sfx(handles.defibrillator, config.powerUp)
end

function flatline()
  sfx(handles.flatline, config.character)
end

function jump()
  sfx(handles.jump, config.character)
end

function boost()
  sfx(handles.boost, config.character)
end

function brickStone()
  sfx(handles.brickStone, config.powerUp)
end

function cardboardBox()
  sfx(handles.cardboardBox, config.powerUp)
end

function carCrash()
  sfx(handles.carCrash, config.powerUp)
end

function powerDown()
  sfx(handles.powerDown, config.powerUp)
end

function powerUp()
  sfx(handles.powerUp, config.powerUp)
end

function stoneBreak()
  sfx(handles.stone_break, config.powerUp)
end

function woodBox()
  sfx(handles.woodBox, config.powerUp)
end

function woodBreak()
  sfx(handles.woodBreak, config.powerUp)
end

function trashcan()
  if math.random(100) > 50 then
    sfx(handles.trashcanA, config.powerUp)
  else
    sfx(handles.trashcanB, config.powerUp)
  end
end

