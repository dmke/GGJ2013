-- moving obstacles
for a = 1, 80, 1 do
	crate = display.newImage("images/crate.png")
	crate.x = 500 * a + math.random(100)
	crate.y = 200
	crate.name = "power_up"
	physics.addBody( crate, { density = 0.2, friction = 0.0, bounce = 0.5} )
	_G.blocks:insert(crate)
end
-- static obstacles
local crates = {}  
for i = 1, 50, 1 do
	crates[i] = display.newImage("images/crate.png")
	crates[i].x = 800 * i + math.random(100)
	crates[i].y = math.random(groundLevel)
	crates[i].name = "static"
	physics.addBody( crates[i], "static", { density = 0.2, friction = 0.0, bounce = 0.1} )
	_G.blocks:insert(crates[i])
end

function updateObstacles()
	for i = 1, 1, 1 do
		if(crates[i].x > 0) then
			print("lower x " .. crates[i].x)
		end	
	end
end