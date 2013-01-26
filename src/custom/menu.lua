--this line is required so that director knows that
--this is a scene that can be loaded into its view
module(..., package.seeall)
--we need to be able to access the director class of
--course so be sure to include this here
local director = require("director")
local sprite = require("sprite")
--everything that you want this scene to do should be
--included in the new function. Everytime the director
--loads a new scene it will look here to figure out what
--to load up.
new = function( params )
--this function will be returned to the director
local menuDisplay = display.newGroup()
--everything from here down to the return line is what makes
--up the scene so... go crazy
local background = display.newImage("images/menu/background.png")
background.x = 240
background.y = 160
local title = display.newImage("images/menu/title.png")
title.x = 240
title.y = 80
local playButton = display.newImage("images/menu/playButton.png")
playButton.x = 240
playButton.y = 220
menuDisplay:insert(background)
menuDisplay:insert(title)
menuDisplay:insert(playButton)
--this is what gets called when playButton gets touched
--the only thing that is does is call the transition
--from this scene to the game scene, "downFlip" is the
--name of the transition that the director uses
local function buttonListener( event )
director:changeScene( "game", "fade" )
return true
end
    --this is a little bit different way to detect touch, but it works
    --well for buttons. Simply add the eventListener to the display object
    --that is the button send the event "touch", which will call the function
    --buttonListener everytime the displayObject is touched.
	playButton:addEventListener("touch", buttonListener )
        --return the display group at the end
    return menuDisplay
end