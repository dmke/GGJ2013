
local physics = require "physics"

--physics.start()   -- must do this before any other physics call!
physics.start( true ) -- prevent all bodies from sleeping
gx, gy = physics.getGravity()
physics.setScale( 30 )
--physics.setDrawMode( "debug" ) -- shows collision engine outlines only
physics.setDrawMode( "hybrid" ) -- overlays collision outlines on normal Corona objects
--physics.setDrawMode( "normal" ) -- the default Corona renderer, with no collision outlines
physics.setPositionIterations( 8 )
physics.setVelocityIterations( 3 )

--physics.addBody( crate1, { density = 1.0, friction = 0.3, bounce = 0.2 } )


--physics.pause()
--physics.stop()


	local    ghost = display.newImage("heart.png")
    ghost.name = ("ghost")
    ghost.x = 180
    ghost.y = 0
    ghost.speed = 0
    --variable used to determine if they are in play or not
    ghost.isAlive = false
    --make the ghosts transparent and more... ghostlike!
    ghost.alpha = .5
    local crateMaterial = { density = 1.0, friction = 0.3, bounce = 0.2 }
 
	physics.addBody( ghost, crateMaterial )
	ghost.bodyType = "dynamic"

	local floor = display.newImage( "gameOver.png", 0, 280, true )  
	physics.addBody( floor, "static", { friction=0.5 } )  


function doStuff()
	print("FUNCTION")
end

function updateLayer(speed)
	--ghost.x = ghost.x + (speed/10)
	--	if(ghost.x > 200) then
	--	ghost.x = 0
	--end
	--ghost:applyForce( 500, 2000, ghost.x, ghost.y )
end

