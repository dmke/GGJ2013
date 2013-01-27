module(..., package.seeall)
local director = require("director")
new = function( params )
    local gameDisplay = display.newGroup()
    display.setStatusBar(display.HiddenStatusBar)

local physics = require("physics")
physics.start()
physics.setGravity(0, 25)
physics.setDrawMode("normal") -- overlays collision outlines on normal Corona objects

--start background music
local player = require("audioPlayer")
player.aggressor()

--setup some variables that we will use to position the ground
groundLevel = display.contentHeight
screenWidth = display.contentWidth

speed = 5
maxHealth = 30
health = maxHealth
time = 0
alive = true

local scoreText = display.newText("score: ", 0, 0, "badaboom", 60)
scoreText:setReferencePoint(display.CenterLeftReferencePoint)
scoreText.x = 60
scoreText.y = 20
local timeText = display.newText("time: ", 0, 0, "badaboom", 60)
timeText:setReferencePoint(display.CenterLeftReferencePoint)
timeText.x = 400
timeText.y = 20


--create a new group to hold all of our physics objects
blocks = display.newGroup()
particles = display.newGroup()

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
		blocks.x = -hero.x + screenWidth/4
		particles.x = -hero.x + 320
	end
end

--how many times to call(-1 means forever))
timer.performWithDelay(1, mainLoop, -1)

local function winConditionCheck( event )
	time = time + 1;
    if(health > 0) then
    	health = health -1
    end
    if(alive==false) then
    	--print("dead")
    elseif(health < 1) then  -- GAME OVER
    	alive = false
    	--scoreText.text = "You loose"
    	hero:prepare("dieing")
		hero:play()
    end
end
timer.performWithDelay( 1000, winConditionCheck,- 1 )

    return gameDisplay
end