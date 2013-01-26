--We will use sprite as a 'sprite handler' to create spritesheets
local sprite = require("sprite")
local player = require("audioPlayer")
require("myBackground")

local spriteSheet = sprite.newSpriteSheet("images/runCollection.png", 80, 80)
local monsterSet = sprite.newSpriteSet(spriteSheet, 1, 7)

sprite.add(monsterSet, "running", 1, 6, 600, 0)
sprite.add(monsterSet, "jumping", 7, 7, 1, 1)

hero = sprite.newSprite(monsterSet)

physics.addBody( hero, { density = 1.0, friction = 0.0, bounce = 0.2, radius = 35 } )
hero.isFixedRotation = true

local function onLocalCollision( self, event )
    if ( event.phase == "began" and event.other.name and event.other.name == "power_up") then
        print("-> TRIGGER")
        event.other:removeSelf()
        game.score = game.score + 1
    end
    if ( event.phase == "ended" and event.other.name and event.other.name == "dynamic") then
        print("-> TRIGGER")
        player.death()
        --physics.removeBody(event.other)
    end
end
hero.collision = onLocalCollision
hero:addEventListener( "collision", hero )

--use prepare to let the sprite know which animation it is going to use
hero:prepare("running")
--calling play will start the loaded animation
hero:play()
game.blocks:insert(hero)
--this is the function that handles the jump events. If the screen is touched on the left side
--then make the monster jump
function touched( event )
    if(event.phase == "began") then
        if(event.x > 241) then
            print("TOUCHED")
            -- jump
            hero:applyForce( -10, -800, hero.x, hero.y )
            --hero:prepare("jumping")
            --hero:play()
            player.jump()
        end
        if(event.x <= 241) then
            print("TOUCHED")
            --step back
            hero:applyForce( 0, 400, hero.x, hero.y )
            --hero:prepare("jumping")
            --hero:play()
            player.stopBackgroundMusic()
        end
     end
end
Runtime:addEventListener("touch", touched, -1)



function updateHero()
	hero:applyForce( 6, 0, hero.x, hero.y )
end
