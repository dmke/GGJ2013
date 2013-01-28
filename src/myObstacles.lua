--todo: remove unused pills
--improve random spawn

local obstacleLevel 		= game.groundLevel
local mapWidth 				= 3000
local minObstacleDistance 	= 500

local carGreenShape 	= { -50,-65, 50,-65, 100,-10, 110,60, -110,60, -100,-10 }
local taxiShape 		= { -50,-50, 50,-50, 140,-10, 150,60, -150,60, -140, 0 	}
local carRedShape 		= { -50,-55, 50,-55, 180,-10, 170,60, -170,60, -180,-10 }

local materialHydrant 	= { density = 8.0, friction = 1.0, bounce = 0.0}
local materialLantern	= { density = 0.6, friction = 1.0, bounce = 0.0}
local materialTrashCan 	= { density = 0.3, friction = 0.7, bounce = 0.2} 
local materialBox	 	= { density = 0.1, friction = 0.1, bounce = 0.3} 
local materialBrick 	= { density = 1.0, friction = 0.3, bounce = 0.0} 
local materialPill	 	= { density = 0.2, friction = 0.1, bounce = 0.1} --radius = 15
local materialCarGreen 	= { density = 2.0, friction = 0.1, bounce = 0.1, shape=carGreenShape }
local materialCarTaxi 	= { density = 2.0, friction = 0.1, bounce = 0.1, shape=taxiShape }
local materialCarRed 	= { density = 2.0, friction = 0.1, bounce = 0.1, shape=carRedShape }

function createPill(x)
	local obstacle = display.newImage("images/pille.png")
	obstacle.x = x
	obstacle.y = 0
	obstacle.name = "power_up"								
	physics.addBody( obstacle, "dynamic", materialPill)
	game.blocks:insert(obstacle)
	return obstacle
end

function createLantern(x)
	local obstacle = display.newImage("images/laterne.png")
	obstacle.x = x
	obstacle.y = obstacleLevel
	obstacle.name = "dynamic"	
	obstacle.sound = "lantern"							
	physics.addBody( obstacle, "dynamic", materialLantern)
	game.blocks:insert(obstacle)
	return obstacle
end

function createHydrant(x)
	local hydrant = display.newImage("images/hydrant.png")
	hydrant.x = x
	hydrant.y = obstacleLevel
	hydrant.name = "dynamic"
	physics.addBody( hydrant, "dynamic", materialHydrant)
	game.blocks:insert(hydrant)
	return hydrant
end

function createTrashCan(x)
	local obstacle = display.newImage("images/trash.png")
	obstacle.x = x
	obstacle.y = obstacleLevel
	obstacle.name = "dynamic"	
	obstacle.sound = "trashcan"								
	physics.addBody( obstacle, "dynamic", materialTrashCan)
	game.blocks:insert(obstacle)
	return obstacle
end

function createBox(x)
	local obstacle = display.newImage("images/karton.png")
	obstacle.x = x
	obstacle.y = obstacleLevel
	obstacle.name = "dynamic"	
	obstacle.sound = "woodBox"								
	physics.addBody( obstacle, "dynamic", materialBox)
	game.blocks:insert(obstacle)
	return obstacle
end

function createBrick(x)
	local obstacle = display.newImage("images/ziegelstein1.png")
	obstacle.x = x
	obstacle.y = obstacleLevel
	obstacle.name = "dynamic"
	obstacle.sound = "brickStone"								
	physics.addBody( obstacle, "dynamic", materialBrick)
	game.blocks:insert(obstacle)
	return obstacle
end

function createRandomCar(x)
	numGen = math.random(3)
  	if(numGen == 1) then
    	obstacle = display.newImage("images/auto_gruen.png")
    	physics.addBody( obstacle, "dynamic", materialCarGreen)
  	end
  	if(numGen == 2) then
   		obstacle = display.newImage("images/taxi.png")
   		physics.addBody( obstacle, "dynamic", materialCarTaxi)
  	end
  	if(numGen == 3) then
   		obstacle = display.newImage("images/car.png")
   		physics.addBody( obstacle, "dynamic", materialCarRed)
  	end	
	obstacle.x = x
	obstacle.y = obstacleLevel
	obstacle.name = "dynamic"									
	game.blocks:insert(obstacle)
	return obstacle
end

function createRandomObstacle(x,y)
	numGen = math.random(6)
  	if(numGen == 1) then
    	return createHydrant(x,y)
  	end
  	if(numGen <= 2) then
   		return createRandomCar(x,y)
  	end
  	if(numGen <= 3) then
   		return createLantern(x,y)
  	end
  	if(numGen <= 4) then
   		return createTrashCan(x,y)
  	end
  	if(numGen <= 5) then
   		return createBox(x,y)
  	end
    if(numGen <= 6) then
   		return createBrick(x,y)
  	end
end

local obstacles = {} 

obstacles[1] = createHydrant(mapWidth)
obstacles[2] = createRandomCar(mapWidth + minObstacleDistance)
obstacles[3] = createLantern(mapWidth + minObstacleDistance + minObstacleDistance)

function updateMyObstacles()
	local lenght = table.getn(obstacles)
	for i = 1, lenght, 1 do
		if(obstacles[i] ~= nil and obstacles[i].x + game.blocks.x < -minObstacleDistance) then --fixme use width instead?
			local lastX = obstacles[i].x
			obstacles[i]:removeSelf()
			obstacles[i] = createRandomObstacle(lastX  +  mapWidth)
			--print("myObstacles -> removed object, spawned object + pill")
			createPill(lastX + mapWidth + math.random(mapWidth))
		end
	end
end