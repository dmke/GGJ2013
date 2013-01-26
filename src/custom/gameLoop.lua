--takes away the display bar at the top of the screen
display.setStatusBar(display.HiddenStatusBar)

--require("myPhysics")

local sprite      = require("sprite")
local cameraGroup = display.newGroup()
local bgGroup     = display.newGroup()

local Configuration = {
  default = {
    speed = 10
  }
}

local images = {
  bg = display.newImage("images/background.png"),
  bgPara = {
    [0] = {
      [0] = display.newImage("images/bgfar1.png"),
      [1] = display.newImage("images/bgfar1.png")
    },
    [1] = {
      [0] = display.newImage("images/bgnear2.png"),
      [1] = display.newImage("images/bgnear2.png")
    }
  }
}

local character = display.newImage("images/heart.png")

bgGroup:insert(images.bg)
bgGroup:insert(images.bgPara[0][0])
bgGroup:insert(images.bgPara[0][1])
bgGroup:insert(images.bgPara[1][0])
bgGroup:insert(images.bgPara[1][1])

cameraGroup:insert(bgGroup)
cameraGroup:insert(character)

function reinit()
  Configuration.speed = Configuration.default.speed

  _w = display.contentWidth/2
  _h = display.contentHeight/2

  images.bg.x, images.bg.y = _w, _h
  images.bgPara[0][0].x, images.bgPara[0][0].y = _w, _h
  images.bgPara[1][0].x, images.bgPara[1][0].y = _w, _h
  images.bgPara[0][1].x, images.bgPara[0][1].y = _w + images.bgPara[0][1].width, _h
  images.bgPara[1][1].x, images.bgPara[1][1].y = _w + images.bgPara[1][1].width, _h
end

local function update(event)
  moveCharacter()
  moveCamera()
  compensateParallax()
  clipElements()
end

function moveCharacter()
  character.x = character.x + Configuration.speed
end

function moveCamera()
  cameraGroup.x = cameraGroup.x - Configuration.speed
end

function compensateParallax()
  images.bg.x = images.bg.x + Configuration.speed
  images.bgPara[0][0].x = images.bgPara[0][0].x + Configuration.speed * 0.9
  images.bgPara[0][1].x = images.bgPara[0][1].x + Configuration.speed * 0.9
  images.bgPara[1][0].x = images.bgPara[1][0].x + Configuration.speed * 0.7
  images.bgPara[1][1].x = images.bgPara[1][1].x + Configuration.speed * 0.7
end

function clipElements()
  local clipPara = function(i,j)
    if images.bgPara[i][j].x < -images.bgPara[i][j].width/2 then
      images.bgPara[i][j].x = images.bgPara[i][j].x + images.bgPara[i][j].width
    end
  end

  clipPara(0, 0)
  clipPara(0, 1)
  clipPara(1, 0)
  clipPara(1, 1)
end


-- initialize and run
reinit()
timer.performWithDelay(1, update, -1)