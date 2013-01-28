--We will use sprite as a 'sprite handler' to create spritesheets
local sprite = require("sprite")
local player = require("audioPlayer")
require("myBackground")
local bloodParticles = require("bloodParticles")
dashing = false

local activity = "";
-- amount of jumps (max. 2, so max. 1 jump in air)
num_jumps = 0

local spriteSheet = sprite.newSpriteSheet("images/dashSprite.png", 85, 85)
local monsterSet = sprite.newSpriteSet(spriteSheet, 1, 48)

sprite.add(monsterSet, "running", 1, 8, 400, 0)
sprite.add(monsterSet, "jumping", 8, 8, 1, 1)
sprite.add(monsterSet, "dieing", 25, 24, 50, 1)
sprite.add(monsterSet, "dash", 10, 2, 50, 1)

hero = sprite.newSprite(monsterSet)

physics.addBody( hero, { density = 1.0, friction = 0.01, bounce = 0.2, radius = 35 } )
hero.isFixedRotation = true

local function onLocalCollision( self, event )
	reset_dash(nil)
	if ( event.phase == "began" ) then
		num_jumps = 0
	end
    if (game.alive and  event.phase == "began" and event.other.name and event.other.name == "power_up") then
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
        elseif event.other.sound == "lantern" then
			player.lantern()
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

function reset_dash(event)
	if dashing then
		hero.density = 1.0
		hero:prepare("running")
		hero:play()
		hero:resetMassData()
		dashing = false
	end
end

function touched(event)
	if game.alive then
	
		if event.phase == "began" and num_jumps < 2 then
			if event.x > display.contentWidth/2 then
				num_jumps = num_jumps + 1
				--print("TOUCHED")
				-- jump
				hero:applyForce( 0, -1800, hero.x, hero.y )
				--hero:prepare("jumping")
				reset_dash(nil)
				--hero:pause()
				player.jump()
				bloodParticles.spray(hero.x, hero.y + hero.height/3, 20)
			end
			if event.x <= display.contentWidth/2 then
				-- dash!
				hero:applyForce( 3500, -700, hero.x, hero.y )
				num_jumps = num_jumps + 2 -- 2 jumps = one dash
				dashing = true
				hero:prepare("dash")
				hero:play()
				hero.density = 8.0
				timer.performWithDelay(1500, reset_dash)
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
