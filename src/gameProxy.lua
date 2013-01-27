module(..., package.seeall)

new = function(params)
  timer.performWithDelay(2000, function(event)
    director:changeScene("game", "fade")
  end)

  local gpDisplay = display.newGroup()
  display.setStatusBar(display.HiddenStatusBar)
  return gpDisplay
end