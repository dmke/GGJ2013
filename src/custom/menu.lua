module(..., package.seeall)

local director = require("director")
local sprite = require("sprite")

new = function( params )
    local menuDisplay = display.newGroup()

    local background = display.newImage("images/menu/background.png")
    background.x = 240
    background.y = 160

    local title = display.newImage("images/menu/title.png")
    title.x = 240
    title.y = 80

    local aboutButton = display.newImage("images/menu/aboutButton.png")
    aboutButton.x = 140
    aboutButton.y = 220

    local playButton = display.newImage("images/menu/playButton.png")
    playButton.x = 340
    playButton.y = 220

    menuDisplay:insert(background)
    menuDisplay:insert(title)
    menuDisplay:insert(playButton)
    menuDisplay:insert(aboutButton)

    local function playButtonListener( event )
        director:changeScene( "game", "fade" )
        return true
    end

    local function aboutButtonListener( event )
        director:changeScene( "about", "fade" )
        return true
    end

    playButton:addEventListener("touch", playButtonListener )
    aboutButton:addEventListener("touch", aboutButtonListener )

    return menuDisplay
end