--This should look familiar, hides the status bar from view
display.setStatusBar(display.HiddenStatusBar)
--'sprite' is what we will be using to create our spritesheets
--'require' lets Corona know that we are making calls out to already
--established functions in another file. "sprite" is already built into
--Corona so we don't have to do any more work on that end
--We will use sprite as a 'sprite handler' to create spritesheets
local sprite = require("sprite")

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
local hero = sprite.newSprite(monsterSet)

--finds the center of the screen
x = display.contentWidth/2
y = display.contentHeight/2
--a boolean variable that shows which direction we are moving
right = true

hero.x = x
hero.y = y

--use prepare to let the sprite know which animation it is going to use
hero:prepare("running")
--calling play will start the loaded animation
hero:play()

function update()
	--if we are running right then keep moving right
	if(right) then
		hero.x = hero.x + 3
	--if we are not moving right keep moving left
	else
		hero.x = hero.x - 3
	end

	--if our monster has run off the screen have him turn
	--and run in the opposite direction. hero.xScale = -1
	--will flip our sprite horizontally
	if(hero.x > 380) then
		right = false
		hero.xScale = -1
	end

	if(hero.x < -60) then
		right = true
		hero.xScale = 1
	end
end

--call the update function
timer.performWithDelay(1, update, -1)