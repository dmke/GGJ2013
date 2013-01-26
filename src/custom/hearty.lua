--We will use sprite as a 'sprite handler' to create spritesheets
local sprite = require("sprite")
<<<<<<< HEAD
=======
local player = require("audioPlayer")
require("myBackground")
>>>>>>> added first iteration of audio playback mechanism
--creating a new spritesheet will break the image you put into even blocks that are 100
--by 100, change those parameters to whatever size your images are. Note that this method
--of sprite creation only works for sprites that are the same size. There are other methods
--to handle sprites of different sizes, but that is beyond the scope of this tutorial.
local spriteSheet = sprite.newSpriteSheet("images/monsterSpriteSheet.png", 100, 100)
--from our spritesheet we create a spriteSet, this is how we how we can group different sprites
--together for organizational purposes. Say for example we had 2 different monsters, we could put
--them in the same spritesheet and create 2 different sprite sets each holding the information for
--their respective frames. This sprite set holds all seven frames in our image,defined by 1 and 7.
local monsterSet = sprite.newSpriteSet(spriteSheet, 1, 7)
--next we make animations from our sprite sets. To do this simply tell the
--function which sprite set to us, next name the animation, give the starting
--frame and the number of frames in the animation, the number of milliseconds
--we want 1 animation to take, and finally the number of times we want the
--animation to run for. 0 will make it run until we tell the animtion to stop
sprite.add(monsterSet, "running", 1, 6, 600, 0)
sprite.add(monsterSet, "jumping", 7, 7, 1, 1)
--the last step is to make a sprite out of our sprite set that holds all of the animtions
hero = sprite.newSprite(monsterSet)

--physics.addBody( hero, { friction=0.5 } )
physics.addBody( hero, { density = 1.0, friction = 0.2, bounce = 0.2, radius = 25 } )
hero.isFixedRotation = true

--use prepare to let the sprite know which animation it is going to use
hero:prepare("running")
--calling play will start the loaded animation
hero:play()
blocks:insert(hero)
--this is the function that handles the jump events. If the screen is touched on the left side
--then make the monster jump
function touched( event )
     if(event.phase == "began") then
          if(event.x > 241) then
              	print("TOUCHED")
              	-- jump
              	hero:applyForce( 0, -200, hero.x, hero.y )
              	hero:prepare("jumping")
				        hero:play()
                player.explosion()
          end
          if(event.x <= 241) then
                print("TOUCHED")
                --step back
                hero:applyForce( -200, 0, hero.x, hero.y )
                hero:prepare("jumping")
                hero:play()
                player.stopBackgroundMusic()
          end
     end
end
Runtime:addEventListener("touch", touched, -1)

function updateHero()
	hero:applyForce( 8, 0, hero.x, hero.y )
end
