display.setStatusBar(display.HiddenStatusBar)

director = require("director")
local mainGroup = display.newGroup()

local main = function()
  mainGroup:insert(director.directorView)
  director:changeScene("menu")
end

main()
