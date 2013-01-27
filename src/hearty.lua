--We will use sprite as a 'sprite handler' to create spritesheets
local sprite = require("sprite")
local player = require("audioPlayer")
require("myBackground")
local bloodParticles = require("bloodParticles")

local activity = "";
-- amount of jumps (max. 2, so max. 1 jump in air)
num_jumps = 0

local spriteSheet = sprite.newSpriteSheet("images/dashSprite.png", 85, 85)
local monsterSet = sprite.newSpriteSet(spriteSheet, 1, 48)

sprite.add(monsterSet, "running", 1, 8, 400, 0)
sprite.add(monsterSet, "jumping", 8, 8, 1, 1)
sprite.add(monsterSet, "dieing", 25, 24, 50, 1)

hero = sprite.newSprite(monsterSet)
physics.addBody( hero, { density = 1.0, friction = 0.01, bounce = 0.2, radius = 35 } )
hero.isFixedRotation = true

local function onLocalCollision( self, event )
	if ( event.phase == "began" ) then
		num_jumps = 0
	end
    if ( event.phase == "began" and event.other.name and event.other.name == "power_up") then
        --print("-> TRIGGER")
        event.other:removeSelf()
        player.powerUp()
        if(game.health < game.maxHealth) then
        	game.health = game.health + 1
        end
    end
    if ( event.phase == "ended" and event.other.name and event.other.name == "dynamic" and game.alive) then
        --print("-> TRIGGER")
        --physics.removeBody(event.other)
        --print("-> RUN")
        if event.other.sound == "trashcan" then
			player.trashcan()
        elseif event.other.sound == "brickStone" then
			player.brickStone()
		elseif event.other.sound == "woodBox" then
			player.woodBox()
		end 
        hero:play()
        bloodParticles.spray(hero.x, hero.y + hero.height/3, 10)
    end
    if ( event.phase == "began" and event.other.name and event.other.name == "static" and game.alive) then
        --print("-> RUN")
        hero:play()
        bloodParticles.spray(hero.x, hero.y + hero.height/3, 5)
    end
end
hero.collision = onLocalCollision
hero:addEventListener( "collision", hero )

hero:prepare("running")
hero:play()
hero.x = 0
hero.y = game.groundLevel - 320
hero:setLinearVelocity( 750, -500, hero.x, hero.y )
game.blocks:insert(hero)

function touched(event)
	if game.alive then
	
		if event.phase == "began" then
			if event.x > display.contentWidth/2 and num_jumps < 2 then
				num_jumps = num_jumps + 1
				--print("TOUCHED")
				-- jump
				hero:applyForce( 0, -1800, hero.x, hero.y )
				--hero:prepare("jumping")
				hero:pause()
				player.jump()
				bloodParticles.spray(hero.x, hero.y + hero.height/3, 20)
			end
			if event.x <= display.contentWidth/2 then
				--print("TOUCHED")
				--step back
				hero:applyForce( 0, 800, hero.x, hero.y )
				--hero:prepare("jumping")
				--hero:play()
				player.stopBackgroundMusic()
			end
		 end
	end
end

Runtime:addEventListener("touch", touched, -1)

function updateHero()
	if game.alive then
		hero:applyForce( 14, 0, hero.x, hero.y )
	end
end
