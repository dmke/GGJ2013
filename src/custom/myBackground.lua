local groundBlockSideWidth = 128

local backGroundNearWidth = 300
local backGroundNearHeight = 720

local backGroundFarWidth = 1280
local backGroundFarHeight = 720

--MIDGROUND
local backgroundnear3 = display.newImage("images/midground3.png")
backgroundnear3.x = backGroundNearWidth * 3
backgroundnear3.y = game.groundLevel - backGroundNearHeight/2
local backgroundnear1 = display.newImage("images/midground1.png")
backgroundnear1.x = backGroundNearWidth
backgroundnear1.y = game.groundLevel - 900/2 -- fix due to file format
local backgroundnear2 = display.newImage("images/midground2.png")
backgroundnear2.x = backGroundNearWidth * 2
backgroundnear2.y = game.groundLevel - backGroundNearHeight/2
local backgroundnear4 = display.newImage("images/midground4.png")
backgroundnear4.x = backGroundNearWidth * 2
backgroundnear4.y = game.groundLevel - backGroundNearHeight/2

--SKYSCRAPER
local backgroundfar = display.newImage("images/backgroundHousing.png")
backgroundfar.x = backGroundFarWidth
backgroundfar.y = game.groundLevel - backGroundNearHeight/2
local backgroundfar2 = display.newImage("images/backgroundHousing.png")
backgroundfar2.x = backGroundFarWidth * 2
backgroundfar2.y = game.groundLevel - backGroundNearHeight/2

--CLOUDS
local backbackground = display.newImage("images/background.png")
backbackground.x = 640
backbackground.y = game.groundLevel - 320

--this for loop will generate all of your ground pieces, we are going to
--make 8 in all.
local numBlocks = 800
local blockArray = {}
for a = 1, numBlocks, 1 do
  isDone = false

  numGen = math.random(6)

  if(numGen == 1 and isDone == false) then
    blockArray[a] = display.newImage("images/floor1.png")
  end
  if(numGen == 2 and isDone == false) then
    blockArray[a] = display.newImage("images/floor2.png")
  end
  if(numGen == 3 and isDone == false) then
    blockArray[a] = display.newImage("images/floor3.png")
  end
  if(numGen == 4 and isDone == false) then
    blockArray[a] = display.newImage("images/floor4.png")
  end
  if(numGen == 5 and isDone == false) then
    blockArray[a] = display.newImage("images/floor5.png")
  end
  if(numGen == 6 and isDone == false) then
    blockArray[a] = display.newImage("images/floor6.png")
  end

  physics.addBody( blockArray[a], "static", { friction=0.1 } )
  isDone = true
  blockArray[a].name = ("static")
  blockArray[a].x = (a * groundBlockSideWidth) - groundBlockSideWidth
  blockArray[a].y = game.groundLevel + groundBlockSideWidth/2
  game.blocks:insert(blockArray[a])
end

function updateMyBackground(speed)
  --far background movement
  backgroundfar.x = backgroundfar.x - (speed/55)
  backgroundfar2.x = backgroundfar2.x - (speed/55)

  --near background movement
  backgroundnear1.x = backgroundnear1.x - (speed/5)
  if(backgroundnear1.x < -backGroundNearWidth/2) then
    backgroundnear1.x = game.screenWidth + backGroundNearWidth
  end
  backgroundnear2.x = backgroundnear2.x - (speed/5)
  if(backgroundnear2.x < -backGroundNearWidth/2) then
    backgroundnear2.x = game.screenWidth + backGroundNearWidth * 1.4 --varianz
  end
  backgroundnear3.x = backgroundnear3.x - (speed/5)
  if(backgroundnear3.x < -backGroundNearWidth/2) then
    backgroundnear3.x = game.screenWidth + backGroundNearWidth
  end
  backgroundnear4.x = backgroundnear4.x - (speed/5)
  if(backgroundnear4.x < -backGroundNearWidth/2) then
    backgroundnear4.x = game.screenWidth + backGroundNearWidth
  end
end
