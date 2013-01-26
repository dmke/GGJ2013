display.setStatusBar(display.HiddenStatusBar)
--by telling Corona to require "director" we are
--telling it to include everything in that file,
--giving us easy access to its functions. This is
--also how you would include any functions or
--"classes" that you created in outside files.
local director = require("director")
local mainGroup = display.newGroup()
local main = function()
--this creates a view that we will use to load
--the other scenes into, so as our game progresses
--technically we are staying in the main.lua file
--and just loading new views or scenes into it
mainGroup:insert(director.directorView)
--we tell the director to load the first scene which
--is going to be the menu
director:changeScene("menu")


end
--be sure to actually call the main function
main()
