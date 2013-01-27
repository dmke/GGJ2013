module(..., package.seeall)

new = function( params )
    local gameDisplay = display.newGroup()
    display.setStatusBar(display.HiddenStatusBar)

local physics = require("physics")
physics.start()
physics.setGravity(0, 25)
physics.setDrawMode("normal") -- ("hybrid") -- overlays collision outlines on normal Corona objects

--start background music
local player = require("audioPlayer")
player.aggressor()

--setup some variables that we will use to position the ground
groundLevel = display.contentHeight + display.screenOriginY/2  --FIXME android nenu
screenWidth = display.contentWidth

speed = 5
maxHealth = 60
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

function collidesound(event)
	player.carCrash()
	timer.cancel(event.source)
end
-- play sound in 1.3 seconds
timer.performWithDelay(1300, collidesound, -1)

function emergencyCollide( self, event )
	if ( event.other.name and event.other.name == "hydrant") then
		e_x = emergency.x
		e_y = emergency.y
		emergency:applyForce( -9000, 0, emergency.x, emergency.y )
		emergency:removeSelf()
		emergency = display.newImage("images/emergencyCrash.png")
		emergency.x = e_x
		emergency.y = e_y
		physics.addBody( emergency, { density = 0.0, friction = 0.0, bounce = 0.0} )
		blocks:insert(emergency)
	end
end

emergency = display.newImage("images/emergency.png")
emergency.x = 0
emergency.y = obstacleLevel
emergency.name = "emergency"
emergency.collision = emergencyCollide
emergency:addEventListener( "collision", emergency )
physics.addBody( emergency, { density = 0.2, friction = 0.008, bounce = 0.0} )
emergency:applyForce( 9000, 0, emergency.x, emergency.y )
blocks:insert(emergency)

lamp = display.newImage("images/hydrant.png")
lamp.x = 1900
lamp.y = obstacleLevel
lamp.name = "hydrant"
physics.addBody( lamp, { density = 0.0, friction = 0.0, bounce = 0.0} )
blocks:insert(lamp)


function mainLoop(event)
	if(alive) then
		updateHero()
		local speed = hero:getLinearVelocity()

		timeText.text = "time: " .. time
		scoreText.text = "health: " .. health

		updateMyBackground(speed/10)
		blocks.x = -hero.x + screenWidth/4
		particles.x = -hero.x + 320
	else
		timer.pause(event.source)
	end
end


function finish(event)
    if alive then
        return false
    end

    hero.currentFrame = 8*3
    hero:pause()
    hero.currentFrame = 8*3

	local gameOver = display.newImage("images/menu/gui_gameover.png")
	gameOver.name = "gameOver"
	gameOver.x = display.contentWidth/2
	gameOver.y = display.contentHeight/2

	local revive = display.newImage("images/menu/gui_gameover_revive.png")
	revive.name = "revive"
	local rev_x = display.contentWidth/2 - 300
	local rev_y = display.contentHeight/2 + 200
	revive.x = rev_x
	revive.y = rev_y
	game.revive = revive

    local function reviveButtonListener( event )
		revive = game.revive
        if event.phase == "began" then
			revive:removeSelf()
			revive = nil
            revive = display.newImage("images/menu/gui_gameover_revive_aktiv.png")
			revive.x = rev_x + 20
			revive.y = rev_y + 10
            player.defibrillator()
        elseif event.phase == "ended" then
            revive:removeSelf()
            revive = nil
            gameOver:removeSelf()
            -- restart game here
        end
		game.revive = revive
        return true
    end
	revive:addEventListener("touch", reviveButtonListener)
end

--how many times to call(-1 means forever))
timer.performWithDelay(1, mainLoop, -1)

    local function winConditionCheck( event )
        time = time + 1;
        if health > 0 then
            health = health -1
        end
        if health < 1 and alive then  -- GAME OVER
            alive = false
            --scoreText.text = "You loose"
            hero:prepare("dieing")
            hero:play()
            player.flatline()
			timer.performWithDelay(1000, finish, -1)
			timer.cancel(event.source)
        end
    end
    timer.performWithDelay(1000, winConditionCheck, -1)

    return gameDisplay
end