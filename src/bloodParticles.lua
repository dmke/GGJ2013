module(..., package.seeall)

local particles = {
  "images/particles/blut_01.png",
  "images/particles/blut_02.png",
  "images/particles/blut_03.png",
  "images/particles/blut_04.png",
  "images/particles/blut_05.png",
  "images/particles/blut_06.png"
}

function spray(x, y, intensity)
  if intensity > 20 then
    intensity = 20
  elseif intensity < 2 then
    intensity = 2
  end

  local sprayGroup = display.newGroup()
  for i = 1, intensity, 1 do
    local particle = display.newImage(particles[math.random(#particles)])
    particle.x = x + math.random(2*intensity) - intensity
    particle.y = y + math.random(2*intensity) - intensity 
    particle:rotate(math.random(90) - 45)
    sprayGroup:insert(particle)
	particle.name = "blood"
	if hero.y-2 < game.groundLevel then
		physics.addBody( particle, { density = 0.05, friction = 0.1, bounce = 0.0} )
	end
  end
  game.particles:insert(sprayGroup)
end

