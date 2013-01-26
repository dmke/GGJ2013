-- moving obstacles
local crates = {}  
for i = 1, 80, 1 do
	crates[i] = display.newImage("images/pille.png")
	crates[i].x = 800 * i + math.random(750)
	crates[i].y = 200
	crates[i].name = "power_up"
	physics.addBody( crates[i], { density = 0.0, friction = 0.0, bounce = 0, radius = 15} )
	game.blocks:insert(crates[i])
end
-- static obstacles (trash can)
local crates = {}  
for i = 1, 50, 1 do
	crates[i] = display.newImage("images/trash.png")
	crates[i].x = 1000 * i + math.random(500)
	crates[i].y = game.groundLevel - 150
	crates[i].name = "dynamic"
	physics.addBody( crates[i], "dynamic", { density = 1.0, friction = 1.2, bounce = 0} )
	game.blocks:insert(crates[i])
end

-- laterne
local crates = {}  
for i = 1, 10, 1 do
	crates[i] = display.newImage("images/laterne.png")
	crates[i].x = 3777 * i + math.random(250)
	crates[i].y = 40
	crates[i].name = "dynamic"
	physics.addBody( crates[i], "dynamic", { density = 1.0, friction = 0.9, bounce = 0} )
	game.blocks:insert(crates[i])
end