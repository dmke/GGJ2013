--takes away the display bar at the top of the screen
display.setStatusBar(display.HiddenStatusBar)

require("myPhysics")

--adds an image to our game centered at x and y coordinates
local backbackground = display.newImage("images/background.png")
backbackground.x = 240
backbackground.y = 160

local backgroundfar = display.newImage("images/bgfar1.png")
backgroundfar.x = 480
backgroundfar.y = 160

local backgroundnear1 = display.newImage("images/bgnear2.png")
backgroundnear1.x = 240
backgroundnear1.y = 160

local backgroundnear2 = display.newImage("images/bgnear2.png")
backgroundnear2.x = 760
backgroundnear2.y = 160

--create a new group to hold all of our blocks
local blocks = display.newGroup()
--blocks:addEventListener("touch",setBomb)

--setup some variables that we will use to position the ground
local groundMin = 420
local groundMax = 340
local groundLevel = groundMin
local speed = 5;

--this for loop will generate all of your ground pieces, we are going to
--make 8 in all.
for a = 1, 8, 1 do
	isDone = false

	--get a random number between 1 and 2, this is what we will use to decide which
	--texture to use for our ground sprites. Doing this will give us random ground
	--pieces so it seems like the ground goes on forever. You can have as many different
	--textures as you want. The more you have the more random it will be, just remember to
	--up the number in math.random(x) to however many textures you have.
	numGen = math.random(2)
	local newBlock
	print (numGen)
	if(numGen == 1 and isDone == false) then
		newBlock = display.newImage("images/ground1.png")
		physics.addBody( newBlock, "static", { friction=0.5 } )
		--newBlock:addEventListener("touch",setBomb)
		isDone = true
	end

	if(numGen == 2 and isDone == false) then
		newBlock = display.newImage("images/ground2.png")
		physics.addBody( newBlock, "static", { friction=0.5 } )
		isDone = true
	end

	--now that we have the right image for the block we are going
	--to give it some member variables that will help us keep track
	--of each block as well as position them where we want them.
	newBlock.name = ("block" .. a)
	newBlock.id = a

	--because a is a variable that is being changed each run we can assign
	--values to the block based on a. In this case we want the x position to
	--be positioned the width of a block apart.
	newBlock.x = (a * 79) - 79
	newBlock.y = groundLevel
	blocks:insert(newBlock)
end

--the update function will control most everything that happens in our game
--this will be called every frame(30 frames per second in our case, which is the Corona SDK default)
local function update( event )
	--updateBackgrounds will call a function made specifically to handle the background movement
	updateBackgrounds()
	updateBlocks()
	--speed = speed + .05
end


function updateBlocks()
	for a = 1, blocks.numChildren, 1 do
		if(a > 1) then
			newX = (blocks[a - 1]).x + 79
		else
			newX = (blocks[8]).x + 79 - speed
		end

		if((blocks[a]).x < -40) then
			(blocks[a]).x, (blocks[a]).y = newX, (blocks[a]).y
		else
			(blocks[a]):translate(speed * -1, 0)
		end
	end
end

function updateBackgrounds()
	--far background movement
	backgroundfar.x = backgroundfar.x - (speed/55)

	--near background movement
	backgroundnear1.x = backgroundnear1.x - (speed/5)
	if(backgroundnear1.x < -239) then
		backgroundnear1.x = 760
	end

	backgroundnear2.x = backgroundnear2.x - (speed/5)
	if(backgroundnear2.x < -239) then
		backgroundnear2.x = 760
	end
end

--this is how we call the update function, make sure that this line comes after the
--actual function or it will not be able to find it
--timer.performWithDelay(how often it will run in milliseconds, function to call,
--how many times to call(-1 means forever))
timer.performWithDelay(1, update, -1)

