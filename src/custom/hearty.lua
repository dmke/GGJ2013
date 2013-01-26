--We will use sprite as a 'sprite handler' to create spritesheets
local sprite = require("sprite")
local player = require("audioPlayer")
require("myBackground")

local activity = "";

--creating a new spritesheet will break the image you put into even blocks that are 100
--by 100, change those parameters to whatever size your images are. Note that this method
--of sprite creation only works for sprites that are the same size. There are other methods
--to handle sprites of different sizes, but that is beyond the scope of this tutorial.
local spriteSheet = sprite.newSpriteSheet("images/dashSprite.png", 85, 85)
--from our spritesheet we create a spriteSet, this is how we how we can group different sprites
--together for organizational purposes. Say for example we had 2 different monsters, we could put
--them in the same spritesheet and create 2 different sprite sets each holding the information for
--their respective frames. This sprite set holds all seven frames in our image,defined by 1 and 7.
local monsterSet = sprite.newSpriteSet(spriteSheet, 1, 48)
--next we make animations from our sprite sets. To do this simply tell the
--function which sprite set to us, next name the animation, give the starting
--frame and the number of frames in the animation, the number of milliseconds
--we want 1 animation to take, and finally the number of times we want the
--animation to run for. 0 will make it run until we tell the animtion to stop
sprite.add(monsterSet, "running", 1, 8, 500, 0)
sprite.add(monsterSet, "jumping", 9, 11, 1, 1)
sprite.add(monsterSet, "dieing", 25, 48, 500, 1)
--the last step is to make a sprite out of our sprite set that holds all of the animtions
hero = sprite.newSprite(monsterSet)
physics.addBody( hero, { density = 1.0, friction = 0.1, bounce = 0.2, radius = 35 } )
hero.isFixedRotation = true

local function onLocalCollision( self, event )  
    if ( event.phase == "began" and event.other.name and event.other.name == "power_up") then  
        --print("-> TRIGGER")
        event.other:removeSelf()  
        if(game.health < maxHealth) then
        	game.health = game.health + 1
        end
    end  
    if ( event.phase == "ended" and event.other.name and event.other.name == "static") then  
        --print("-> TRIGGER")
        --physics.removeBody(event.other)        
    end  
    if ( event.phase == "began" and event.other.name and event.other.name == "ground") then  
        print("-> RUN")
        if(activity ~= "running") then
            activity = "running"
       	 	--hero:prepare("running")
			--hero:play()  
        end    
    end  
end  
hero.collision = onLocalCollision  
hero:addEventListener( "collision", hero )  

--use prepare to let the sprite know which animation it is going to use
hero:prepare("running")
--calling play will start the loaded animation
hero:play()
hero.x = -80
hero.y = 200
hero:applyForce( 1000, -1000, hero.x, hero.y )
game.blocks:insert(hero)
--this is the function that handles the jump events. If the screen is touched on the left side
--then make the monster jump
function touched( event )
	if(game.alive) then
	     if(event.phase == "began") then
	          if(event.x > 241) then
	              	-- jump
	              	hero:applyForce( -10, -800, hero.x, hero.y )
	              	--hero:prepare("jumping")
					--hero:play()
	                player.explosion()
	          end
	          if(event.x <= 241) then
	                --move down
	                hero:applyForce( 0, 400, hero.x, hero.y )
	                player.stopBackgroundMusic()
	          end
	     end
	end
end
Runtime:addEventListener("touch", touched, -1)


function updateHero()
	if(game.alive) then
		hero:applyForce( 6, 0, hero.x, hero.y )
	end
end
