local obstacleLevel = game.groundLevel - 50

-- pills
local pills = {}  
for i = 1, 60, 1 do
	pills[i] = display.newImage("images/pille.png")
	pills[i].x = 1000 * i + math.random(750)
	pills[i].y = obstacleLevel
	pills[i].name = "power_up"
	physics.addBody( pills[i], { density = 0.0, friction = 0.1, bounce = 0, radius = 15} )
	game.blocks:insert(pills[i])
end

-- trash cans
local trash = {}  
for i = 1, 20, 1 do
	trash[i] = display.newImage("images/trash.png")
	trash[i].x = 2000 * i + math.random(500)
	trash[i].y = obstacleLevel
	trash[i].name = "dynamic"
	physics.addBody( trash[i], "dynamic", { density = 1.0, friction = 0.7, bounce = 0.1} )
	game.blocks:insert(trash[i])
end

-- hydrant
local hydrant = {}  
for i = 1, 10, 1 do
	hydrant[i] = display.newImage("images/hydrant.png")
	hydrant[i].x = 4000 * i + math.random(250)
	hydrant[i].y = obstacleLevel
	hydrant[i].name = "static"
	physics.addBody( hydrant[i], "static", { density = 1.0, friction = 0.1, bounce = 0.1} )
	game.blocks:insert(hydrant[i])
end

-- lanterns
local lanterns = {}  
for i = 1, 10, 1 do
	lanterns[i] = display.newImage("images/laterne.png")
	lanterns[i].x = 3000 * i + math.random(250)
	lanterns[i].y = obstacleLevel
	lanterns[i].name = "dynamic"
	physics.addBody( lanterns[i], "dynamic", { density = 1.0, friction = 1.0, bounce = 0.0} )
	game.blocks:insert(lanterns[i])
end

-- boxes
local boxes = {}  
for i = 1, 10, 1 do
	boxes[i] = display.newImage("images/karton.png")
	boxes[i].x = 2000 * i + math.random(250)
	boxes[i].y = obstacleLevel
	boxes[i].name = "dynamic"
	physics.addBody( boxes[i], "dynamic", { density = 0.1, friction = 0.1, bounce = 0.3} )
	game.blocks:insert(boxes[i])
end

-- cars
local cars = {}  
for i = 1, 10, 1 do
	cars[i] = display.newImage("images/auto_gruen.png")
	cars[i].x = 6000 * i + math.random(250)
	cars[i].y = obstacleLevel
	cars[i].name = "dynamic"
	physics.addBody( cars[i], "dynamic", { density = 2.0, friction = 0.1, bounce = 0.1} )
	game.blocks:insert(cars[i])
end

-- testcode, use for random generator?
local numBlocks = 0
local obstacleArray = {}
for i = 1, numBlocks, 1 do
	isDone = false

	numGen = math.random(1)

	print (numGen)
	if(numGen == 1 and isDone == false) then
		obstacleArray[i] = display.newImage("images/auto_gruen.png")
		physics.addBody( obstacleArray[i], "dynamic", { density = 2.0, friction = 0.1, bounce = 0.1} )
	end	
	obstacleArray[i].x = 1000 * i + math.random(500)
	obstacleArray[i].y = obstacleLevel
	obstacleArray[i].name = "dynamic"
	game.blocks:insert(obstacleArray[i])
	isDone = true

end