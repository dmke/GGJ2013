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
    --this is a little bit different way to detect touch, but it works
    --well for buttons. Simply add the eventListener to the display object
    --that is the button send the event "touch", which will call the function
    --buttonListener everytime the displayObject is touched.
	backbackground:addEventListener("touch", backButtonListener )

    return gameDisplay
end