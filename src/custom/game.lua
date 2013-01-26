module(..., package.seeall)
local director = require("director")
new = function( params )
    local gameDisplay = display.newGroup()
    display.setStatusBar(display.HiddenStatusBar)



local physics = require("physics")
physics.start()
physics.setDrawMode("hybrid") -- overlays collision outlines on normal Corona objects

--start background music
local player = require("audioPlayer")
player.aggressor()

--setup some variables that we will use to position the ground
groundMin = 420
groundMax = 340
groundLevel = groundMin
speed = 5;
maxHealth = 10
health = maxHealth
time = 0
alive = true

local scoreText = display.newText("score: ", 0, 0, "Arial", 20)
scoreText:setReferencePoint(display.CenterLeftReferencePoint)
scoreText.x = 30
scoreText.y = 30
local timeText = display.newText("time: ", 0, 0, "Arial", 20)
timeText:setReferencePoint(display.CenterLeftReferencePoint)
timeText.x = 30
timeText.y = 10


--create a new group to hold all of our physics objects
blocks = display.newGroup()


require("myBackground")
require("hearty")
require("myObstacles")

function mainLoop()
	if(alive) then
		updateHero()
		local speed = hero:getLinearVelocity()
		--print("speed " .. speed)
		
		timeText.text = "time: " .. time 
		scoreText.text = "health: " .. health	
			
		updateMyBackground(speed/10)
		blocks.x = -hero.x + 80
	end
end

--how many times to call(-1 means forever))
timer.performWithDelay(1, mainLoop, -1)

local function winConditionCheck( event )
	time = time + 1;
    if(health > 0) then
    	health = health -1
    end
    -- GAME OVER
    if(health < 1) then
    	alive = false
    	scoreText.text = "You loose"
    end
end
timer.performWithDelay( 1000, winConditionCheck,- 1 )

    return gameDisplay
end