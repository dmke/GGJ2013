local crate = display.newImage("images/crate.png")
crate.x = 300
crate.y = 200
physics.addBody( crate, { density = 0.5, friction = 0.3, bounce = 0.2} )
blocks:insert(crate)

local crate2 = display.newImage("images/crate.png")
crate2.x = 450
crate2.y = 200
physics.addBody( crate2, { density = 0.5, friction = 0.3, bounce = 0.2} )
blocks:insert(crate2)

local crate3 = display.newImage("images/crate.png")
crate3.x = 450
crate3.y = 200
physics.addBody( crate3, "static", { density = 1.0, friction = 0.3, bounce = 0.2} )
blocks:insert(crate3)

local crate4 = display.newImage("images/crate.png")
crate4.x = 400
crate4.y = 200
physics.addBody( crate4, "static", { density = 1.0, friction = 0.3, bounce = 0.2} )
blocks:insert(crate4)
