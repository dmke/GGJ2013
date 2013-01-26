-- moving obstacles
local crates = {}  
for i = 1, 80, 1 do
	crates[i] = display.newImage("images/crate.png")
	crates[i].x = 500 * i + math.random(100)
	crates[i].y = 200
	crates[i].name = "power_up"
	physics.addBody( crates[i], { density = 0.0, friction = 0.0, bounce = 0, radius = 10} )
	game.blocks:insert(crates[i])
end
-- static obstacles
local crates = {}  
for i = 1, 50, 1 do
	crates[i] = display.newImage("images/crate.png")
	crates[i].x = 1000 * i + math.random(100)
	crates[i].y = game.groundLevel - 150
	crates[i].name = "static"
	physics.addBody( crates[i], "dynamic", { density = 1.0, friction = 1.2, bounce = 0} )
	game.blocks:insert(crates[i])
end