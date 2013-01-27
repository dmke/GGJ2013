module(..., package.seeall)

new = function(params)
    local menuDisplay = display.newGroup()

    local whiteBg = display.newRect(0, 0, 1280, 720)
    whiteBg.strokeWidth = 0
    whiteBg:setFillColor(255, 255, 255)
    menuDisplay:insert(whiteBg)

    local background = display.newImage("images/menu/gui_startscreen_titel.png")
    background.x = 640
    background.y = 360
    menuDisplay:insert(background)

    local aboutButton = display.newImage("images/menu/gui_startscreen_credits.png")
    aboutButton.x = 370
    aboutButton.y = 600
    menuDisplay:insert(aboutButton)

    local playButton = display.newImage("images/menu/gui_startscreen_play.png")
    playButton.x = 200
    playButton.y = 520
    menuDisplay:insert(playButton)

    local function playButtonListener(event)
        if event.phase == "began" then
            playButton = display.newImage("images/menu/gui_startscreen_play_aktiv.png")
        else
            playButton = display.newImage("images/menu/gui_startscreen_play.png")
            director:changeScene("game", "fade")
        end
        playButton.x = 200
        playButton.y = 520
        return true
    end

    local function aboutButtonListener(event)
        if event.phase == "began" then
            aboutButton = display.newImage("images/menu/gui_startscreen_credits_aktiv.png")
        else
            aboutButton = display.newImage("images/menu/gui_startscreen_credits.png")
            director:changeScene("about", "fade")
        end
        aboutButton.x = 370
        aboutButton.y = 600
        return true
    end

    playButton:addEventListener("touch", playButtonListener)
    aboutButton:addEventListener("touch", aboutButtonListener)

    return menuDisplay
end