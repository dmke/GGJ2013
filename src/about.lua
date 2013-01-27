module(..., package.seeall)
local director = require("director")

new = function( params )
    local gameDisplay = display.newGroup()
    display.setStatusBar(display.HiddenStatusBar)

    local backbackground = display.newImage("images/menu/about.png")
    backbackground.x = 240
    backbackground.y = 160

    local function backButtonListener( event )
        director:changeScene( "menu", "fade" )
        return true
    end
	backbackground:addEventListener("touch", backButtonListener )

    return gameDisplay
end