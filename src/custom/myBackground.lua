local groundBlockSideWidth = 80

local backGroundNearWidth = 300
local backGroundNearHeight = 720

local backGroundFarWidth = 1280
local backGroundFarHeight = 720

--HOUSES
local backgroundnear1 = display.newImage("images/midground1.png")
backgroundnear1.x = backGroundNearWidth
backgroundnear1.y = game.groundLevel - 320
local backgroundnear2 = display.newImage("images/midground2.png")
backgroundnear2.x = backGroundNearWidth * 2
backgroundnear2.y = game.groundLevel - 320

--SKYSCRAPER
local backgroundfar = display.newImage("images/backgroundHousing.png")
backgroundfar.x = backGroundFarWidth
backgroundfar.y = game.groundLevel - 320
local backgroundfar2 = display.newImage("images/backgroundHousing.png")
backgroundfar2.x = backGroundFarWidth * 2
backgroundfar2.y = game.groundLevel - 320

--CLOUDS
local backbackground = display.newImage("images/background.png")
backbackground.x = 640
backbackground.y = game.groundLevel - 320

--this for loop will generate all of your ground pieces, we are going to
--make 8 in all.
local numBlocks = 800
local blockArray = {}
for a = 1, numBlocks, 1 do
	isDone = false

	--get a random number between 1 and 2, this is what we will use to decide which
	--texture to use for our ground sprites. Doing this will give us random ground
	--pieces so it seems like the ground goes on forever. You can have as many different
	--textures as you want. The more you have the more random it will be, just remember to
	--up the number in math.random(x) to however many textures you have.
	numGen = math.random(2)

	print (numGen)
	if(numGen == 1 and isDone == false) then
		blockArray[a] = display.newImage("images/floor1.png")
		physics.addBody( blockArray[a], "static", { friction=0.1 } )
		isDone = true
	end

	if(numGen == 2 and isDone == false) then
		blockArray[a] = display.newImage("images/floor2.png")
		physics.addBody( blockArray[a], "static", { friction=0.1 } )
		isDone = true
	end

	--now that we have the right image for the block we are going
	--to give it some member variables that will help us keep track
	--of each block as well as position them where we want them.
	blockArray[a].name = ("static")
	--because a is a variable that is being changed each run we can assign
	--values to the block based on a. In this case we want the x position to
	--be positioned the width of a block apart.
	blockArray[a].x = (a * groundBlockSideWidth) - groundBlockSideWidth
	blockArray[a].y = game.groundLevel + groundBlockSideWidth
	game.blocks:insert(blockArray[a])
end

--the update function will control most everything that happens in our game
--this will be called every frame(30 frames per second in our case, which is the Corona SDK default)
function updateMyBackground(speed)
	--updateBackgrounds will call a function made specifically to handle the background movement
		--far background movement
	backgroundfar.x = backgroundfar.x - (speed/55)
	backgroundfar2.x = backgroundfar2.x - (speed/55)
	
	--near background movement
	backgroundnear1.x = backgroundnear1.x - (speed/5)
	if(backgroundnear1.x < -backGroundNearWidth/2) then
		backgroundnear1.x = game.screenWidth + backGroundNearWidth
	end
	backgroundnear2.x = backgroundnear2.x - (speed/5)
	if(backgroundnear2.x < -backGroundNearWidth/2) then
		backgroundnear2.x = game.screenWidth + backGroundNearWidth * 1.4 --varianz
	end
	--print("x: " .. ground.x)
	--for a = 1, numBlocks, 1 do
		--print("x " .. blockArray[a].x)
		--rectContentX, rectContentY = blockArray[a]:localToContent( 0, 0 )
		--print("rectContentX " .. rectContentX)
           	--if(blockArray[a].x < -rectContentX) then
           	 	--blockArray[a].x = blockArray[a].x + display.viewableContentWidth 
           	 --end
	--end
end
