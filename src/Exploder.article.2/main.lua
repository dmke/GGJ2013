-- 
-- Abstract: Bullet sample project
-- Demonstrates "isBullet" attribute for continuous collision detection
-- 
-- Version: 1.1 (revised for Alpha 2)
-- 
-- Sample code is MIT licensed, see http://developer.anscamobile.com/code/license
-- Copyright (C) 2010 ANSCA Inc. All Rights Reserved.

local physics = require("physics")
local media = require("media")

physics.start()

physics.setScale( 40 )

display.setStatusBar( display.HiddenStatusBar )

-- The final "true" parameter overrides Corona's auto-scaling of large images
local background = display.newImage( "bricks.png", 0, 0, true )
background.x = display.contentWidth / 2
background.y = display.contentHeight / 2

local floor = display.newImage( "floor.png", 0, 280, true )
physics.addBody( floor, "static", { friction=0.5 } )

local explosionSound = media.newEventSound( "explosion.mp3" )
 
local crates = {}

for i = 1, 5 do
	for j = 1, 5 do
		crates[i] = display.newImage( "crate.png", 140 + (i*50), 220 - (j*50) )
		physics.addBody( crates[i], { density=0.2, friction=0.1, bounce=0.5 } )
	end
end

local function onLocalCollision( self, event )
        if ( event.phase == "began" and self.myName == "circle" ) then
			local forcex = event.other.x-self.x
			local forcey = event.other.y-self.y
			if(forcex < 0) then
				forcex = 0-(80 + forcex)-12
			else
				forcex = 80 - forcex+12
			end
			event.other:applyForce( forcex, forcey, self.x, self.y )
			if(math.abs(forcex) > 60 or math.abs(forcey) > 60) then
				local explosion = display.newImage( "explosion.png", event.other.x, event.other.y )
				event.other:removeSelf()
				local function removeExplosion( event )
					explosion:removeSelf()
				end

				timer.performWithDelay( 50,  removeExplosion)
			end

        end
end

local function setBomb ( event )
	if(event.phase == "began") then
		local bomb = display.newImage( "bomb.png", event.x,event.y )
		physics.addBody( bomb, { density=0.2, friction=0.1, bounce=0.5 } )
		
		local circle = ""
		local explosion = ""
		local function blast( event )
			media.playEventSound( explosionSound )
		    circle = display.newCircle( bomb.x, bomb.y, 80 )
			explosion = display.newImage( "explosion.png", bomb.x, bomb.y )
			bomb:removeSelf()
			circle:setFillColor(0,0,0, 0)
			physics.addBody( circle, "static", {isSensor = true} )
			circle.myName = "circle"
			circle.collision = onLocalCollision
			circle:addEventListener( "collision", circle )
		 end

		 local function removeStuff( event )
			circle:removeSelf()
			explosion:removeSelf()
		 end
		 timer.performWithDelay(3000, blast )
		 timer.performWithDelay(3100, removeStuff)
	end
end
background:addEventListener("touch",setBomb)