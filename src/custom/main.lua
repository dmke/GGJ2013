display.setStatusBar(display.HiddenStatusBar)

local physics = require("physics")
--local media = require("media")
physics.start()
physics.setDrawMode("hybrid") -- overlays collision outlines on normal Corona objects

--setup some variables that we will use to position the ground
groundMin = 420
groundMax = 340
groundLevel = groundMin
speed = 5;

--create a new group to hold all of our physics objects
blocks = display.newGroup()

require("myBackground")
require("hearty")
require("myObstacles")

function mainLoop()
	updateHero()
	speed = hero:getLinearVelocity()
	--print("speed " .. speed)
	
	updateMyBackground(speed/10)
		
	blocks.x = -hero.x + display.viewableContentWidth/3 
end


--how many times to call(-1 means forever))
timer.performWithDelay(1, mainLoop, -1)