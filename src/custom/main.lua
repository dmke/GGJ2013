display.setStatusBar(display.HiddenStatusBar)

local physics = require("physics")
local media = require("media")
physics.start()
physics.setDrawMode( "hybrid" ) -- overlays collision outlines on normal Corona objects


require("myBackground")
require("hearty")

