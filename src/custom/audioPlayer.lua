module(..., package.seeall)

local audio = require("audio")

local handles = {
  explosion     = audio.loadSound("audio/explosion.mp3"),
  death         = audio.loadSound("audio/dogpoop_die.mp3"),
  defibrillator = audio.loadSound("audio/defibrillator.mp3"),
  flatline      = audio.loadSound("audio/flatline.mp3"),
  jump          = audio.loadSound("audio/jump.mp3"),
  boost         = audio.loadSound("audio/boost.mp3"),
  brickStone    = audio.loadSound("audio/brick_stone.mp3"),
  cardboardBox  = audio.loadSound("audio/cardboard_box.mp3"),
  carCrash      = audio.loadSound("audio/car_crash.mp3"),
  powerDown     = audio.loadSound("audio/powerdown.mp3"),
  powerUp       = audio.loadSound("audio/powerup.mp3"),
  stoneBreak    = audio.loadSound("audio/stone_break.mp3"),
  trashcanA     = audio.loadSound("audio/trashcan_a.mp3"),
  trashcanB     = audio.loadSound("audio/trashcan_b.mp3"),
  woodBox       = audio.loadSound("audio/wood_box.mp3"),
  woodBreak     = audio.loadSound("audio/wood_break.mp3"),


  heartbeat = audio.loadSound("audio/heartbeat.mp3"),
  aggressor = {
    audio.loadSound("audio/music_loop_1.mp3"),
    audio.loadSound("audio/music_loop_2.mp3"),
    audio.loadSound("audio/music_loop_3.mp3")
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
  audio.play(sample, { channel=cfg.ch })
end

local function startBackgroundMusic(theme)
  local function playBackgroundMusic(event)
    if event == nil then
      config.bgMusic.pitch = 0.9
    end
    if event == nil or event.completed then
      local sample = theme[math.random(#theme)]
      _, config.bgMusic.src = audio.play(sample, { channel=config.bgMusic.ch, onComplete = playBackgroundMusic })

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
      _, config.bgHeart.src = audio.play(handles.heartbeat, { channel=config.bgHeart.ch, onComplete=playHeartbeat })
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

