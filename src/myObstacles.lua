obstacleLevel = game.groundLevel - 50
topSpawnLevel = obstacleLevel - 500


-- hydrant
local hydrant = {}  
for i = 1, 10, 1 do
	hydrant[i] = display.newImage("images/hydrant.png")
	hydrant[i].x = 8000 * i + math.random(250) + 1200
	hydrant[i].y = obstacleLevel
	hydrant[i].name = "static"
	physics.addBody( hydrant[i], "static", { density = 1.0, friction = 0.1, bounce = 0.1} )
	game.blocks:insert(hydrant[i])
end

-- cars
local carSmallShape ={ -50,-65, 50,-65, 100,-10, 110,60, -110,60, -100,-10 }
local taxiShape 	={ -50,-50, 50,-50, 140,-10, 150,60, -150,60, -140, 0 }
local carRedShape 	={ -50,-55, 50,-55, 180,-10, 170,60, -170,60, -180,-10 }

local cars = {}  
for i = 1, 10, 1 do
	cars[i] = display.newImage("images/auto_gruen.png")
	cars[i].x = 6000 * i + math.random(250) + 1200
	cars[i].y = obstacleLevel
	cars[i].name = "dynamic"								
	physics.addBody( cars[i], "dynamic", { density = 2.0, friction = 0.1, bounce = 0.1 , shape=carSmallShape })
	game.blocks:insert(cars[i])
end

local taxi = {}
for i = 1, 10, 1 do
	taxi[i] = display.newImage("images/taxi.png")
	taxi[i].x = 5000 * i + math.random(5000) + 1200
	taxi[i].y = obstacleLevel
	taxi[i].name = "dynamic"
	physics.addBody( taxi[i], "dynamic", { density = 2.0, friction = 0.1, bounce = 0.1, shape=taxiShape })
	game.blocks:insert(taxi[i])
end

local red_car = {}
for i = 1, 10, 1 do
	red_car[i] = display.newImage("images/car.png")
	red_car[i].x = 8000 * i + math.random(5000) + 1200
	red_car[i].y = obstacleLevel
	red_car[i].name = "dynamic"
	physics.addBody( red_car[i], "dynamic", { density = 2.0, friction = 0.1, bounce = 0.1, shape=carRedShape })
	game.blocks:insert(red_car[i])
end

-- lanterns
local lanterns = {}  
for i = 1, 10, 1 do
	lanterns[i] = display.newImage("images/laterne.png")
	lanterns[i].x = 3000 * i + math.random(250) + 1200
	lanterns[i].y = obstacleLevel
	lanterns[i].name = "dynamic"
	lanterns[i].sound = "lantern"
	physics.addBody( lanterns[i], "dynamic", { density = 0.6, friction = 1.0, bounce = 0.0} )
	game.blocks:insert(lanterns[i])
end

-- trash cans
local trash = {}  
for i = 1, 20, 1 do
	trash[i] = display.newImage("images/trash.png")
	trash[i].x = 2000 * i + math.random(500) + 1200
	trash[i].y = obstacleLevel
	trash[i].name = "dynamic"
	trash[i].sound = "trashcan"
	physics.addBody( trash[i], "dynamic", { density = 0.3, friction = 0.7, bounce = 0.2} )
	game.blocks:insert(trash[i])
end

-- boxes
local boxes = {}  
for i = 1, 10, 1 do
	boxes[i] = display.newImage("images/karton.png")
	boxes[i].x = 2000 * i + math.random(250) + 1200
	boxes[i].y = topSpawnLevel
	boxes[i].name = "dynamic"
	boxes[i].sound = "woodBox" 
	physics.addBody( boxes[i], "dynamic", { density = 0.1, friction = 0.1, bounce = 0.3} )
	game.blocks:insert(boxes[i])
end

-- ziegel
local pills = {}  
for i = 1, 8, 1 do
	pills[i] = display.newImage("images/ziegelstein1.png")
	pills[i].x = 4000  + math.random(500)
	pills[i].y = topSpawnLevel - math.random(4)
	pills[i].name = "dynamic"
	pills[i].sound = "brickStone"
	physics.addBody( pills[i], { density = 3.0, friction = 0.3, bounce = 0.0} )
	game.blocks:insert(pills[i])
end

-- pills
local pills = {}  
for i = 1, 60, 1 do
	pills[i] = display.newImage("images/pille.png")
	pills[i].x = 1000 * i + math.random(750) + 1200
	pills[i].y = topSpawnLevel
	pills[i].name = "power_up"
	physics.addBody( pills[i], { density = 0.2, friction = 0.1, bounce = 0.1, radius = 15} )
	game.blocks:insert(pills[i])
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
	obstacleArray[i].x = 1000 * i + math.random(500) + 1200
	obstacleArray[i].y = obstacleLevel
	obstacleArray[i].name = "dynamic"
	game.blocks:insert(obstacleArray[i])
	isDone = true

end