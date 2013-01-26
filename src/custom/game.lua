module(..., package.seeall)

require("entity")
require("myStuff")



local director = require("director")






new = function( params )
    local gameDisplay = display.newGroup()
    display.setStatusBar(display.HiddenStatusBar)
local sprite = require("sprite")

--these 2 variables will be the checks that control our event system.
local inEvent = 0
local eventRun = 0

local backbackground = display.newImage("images/background.png")
backbackground.x = 240
backbackground.y = 160

local backgroundfar = display.newImage("images/bgfar1.png")
backgroundfar.x = 480
backgroundfar.y = 160

local backgroundnear1 = display.newImage("images/bgnear2.png")
backgroundnear1.x = 240
backgroundnear1.y = 160

local backgroundnear2 = display.newImage("images/bgnear2.png")
backgroundnear2.x = 760
backgroundnear2.y = 160

local gameOver = display.newImage("images/gameOver.png")
gameOver.name = "gameOver"
gameOver.x = 0
gameOver.y = 500

local yesButton = display.newImage("images/yesButton.png")
yesButton.x = 100
yesButton.y = 600

local noButton = display.newImage("images/noButton.png")
noButton.x = 100
noButton.y = 600



--variable to hold our game's score
local score = 0
--scoreText is another variable that holds a string that has the score information
--when we update the score we will always need to update this string as well
--*****Note for android users, you may need to include the file extension of the font
-- that you choose here, so it would be BorisBlackBloxx.ttf there******
local scoreText = display.newText("score: " .. score, 0, 0, "Arial", 50)
--This is important because if you dont have this line the text will constantly keep
--centering itself rather than aligning itself up neatly along a fixed point
scoreText:setReferencePoint(display.CenterLeftReferencePoint)
scoreText.x = 0
scoreText.y = 30

local blocks = display.newGroup()
local player = display.newGroup()
local screen = display.newGroup()
local ghosts = display.newGroup()
local spikes = display.newGroup()
local blasts = display.newGroup()
local bossSpits = display.newGroup()

local groundMin = 420
local groundMax = 340
local groundLevel = groundMin
local speed = 5

--create ghosts and set their position to be off-screen
for a = 1, 3, 1 do
    ghost = display.newImage("images/ghost.png")
    ghost.name = ("ghost" .. a)
    ghost.id = a
    ghost.x = 800
    ghost.y = 600
    ghost.speed = 0
    --variable used to determine if they are in play or not
    ghost.isAlive = false
    --make the ghosts transparent and more... ghostlike!
    ghost.alpha = .5
    ghosts:insert(ghost)
end

--create spikes
for a = 1, 3, 1 do
    spike = display.newImage("images/spikeBlock.png")
    spike.name = ("spike" .. a)
    spike.id = a
    spike.x = 900
    spike.y = 500
    spike.isAlive = false
    spikes:insert(spike)
end

--create blasts
for a=1, 5, 1 do
    blast = display.newImage("images/blast.png")
    blast.name = ("blast" .. a)
    blast.id = a
    blast.x = 800
    blast.y = 500
    blast.isAlive = false
    blasts:insert(blast)
end

for a = 1, 8, 1 do
	isDone = false
	numGen = math.random(2)
	local newBlock
	if(numGen == 1 and isDone == false) then
		newBlock = display.newImage("images/ground1.png")
		isDone = true
	end

	if(numGen == 2 and isDone == false) then
		newBlock = display.newImage("images/ground2.png")
		isDone = true
	end

	if(numGen == 3 and isDone == false) then
		newBlock = display.newImage("images/ground3.png")
		isDone = true
	end

	if(isDone == false) then
		newBlock = display.newImage("images/ground1.png")
	end
	newBlock.name = ("block" .. a)
	newBlock.id = a
	newBlock.x = (a * 79) - 79
	newBlock.y = groundLevel
	blocks:insert(newBlock)
end

local boss = display.newImage("images/boss.png", 150, 150)
boss.x = 300
boss.y = 550
boss.isAlive = false
boss.health = 10
boss.goingDown = true
boss.canShoot = false
boss.spitCycle = 0

for a=1, 3, 1 do
    bossSpit = display.newImage("images/bossSpit.png")
    bossSpit.x = 400
    bossSpit.y = 550
    bossSpit.isAlive = false
	bossSpit.speed = 3
    bossSpits:insert(bossSpit)
end



--create our sprite sheet
local spriteSheet = sprite.newSpriteSheet("images/monsterSpriteSheet.png", 100, 100)
local monsterSet = sprite.newSpriteSet(spriteSheet, 1, 7)
sprite.add(monsterSet, "running", 1, 6, 600, 0)
sprite.add(monsterSet, "jumping", 7, 7, 1, 1)

local monster = sprite.newSprite(monsterSet)
monster:prepare("running")
monster:play()
monster.x = 60
monster.y = 200
monster.gravity = -6
monster.accel = 0
monster.isAlive = true

local collisionRect = display.newRect(monster.x + 36, monster.y, 1, 70)
collisionRect.strokeWidth = 1
collisionRect:setFillColor(140, 140, 140)
collisionRect:setStrokeColor(180, 180, 180)
collisionRect.alpha = 0

--most of the order here does not matter as long as the backgrounds
--are in back and the ghosts and monster are at the end
screen:insert(backbackground)
screen:insert(backgroundfar)
screen:insert(backgroundnear1)
screen:insert(backgroundnear2)
screen:insert(blocks)
screen:insert(spikes)
screen:insert(blasts)
screen:insert(ghosts)
screen:insert(monster)
screen:insert(boss)
screen:insert(bossSpits)
screen:insert(collisionRect)
screen:insert(scoreText)
screen:insert(gameOver)
screen:insert(yesButton)
screen:insert(noButton)

local function update( event )
	updateBackgrounds()
	updateSpeed()
	updateMonster()
	updateBlocks()
	updateBlasts()
	updateSpikes()
	updateGhosts()
	updateBossSpit()

	updateLayer(speed)

	if(boss.isAlive == true) then
		updateBoss()
	end
	checkCollisions()
end

function updateBoss()
	if(boss.health > 0) then
		if(boss.y > 210) then
			boss.goingDown = false
		end
		if(boss.y < 100) then
			boss.goingDown = true
		end
		if(boss.goingDown) then
			boss.y = boss.y + 2
		else
			boss.y = boss.y - 2
		end
	else
		boss.alpha = boss.alpha - .01
	end

	if(boss.alpha <= 0) then
		boss.isAlive = false
		boss.x = 300
		boss.y = 550
		boss.alpha = 1
		boss.health = 10
		inEvent = 0
		boss.spitCycle = 0
	end
end

function updateBossSpit()
	for a = 1, bossSpits.numChildren, 1 do
		if(bossSpits[a].isAlive) then
			(bossSpits[a]):translate(speed * -1, 0)
			if(bossSpits[a].y > monster.y) then
				bossSpits[a].y = bossSpits[a].y - 1
			end
			if(bossSpits[a].y < monster.y) then
				bossSpits[a].y = bossSpits[a].y + 1
			end
			if(bossSpits[a].x < -80) then
				bossSpits[a].x = 400
				bossSpits[a].y = 550
				bossSpits[a].speed = 0
				bossSpits[a].isAlive = false;
			end
		end
    end
end

function checkCollisions()
        --boolean variable so we know if we were on the ground in the last frame
	wasOnGround = onGround

	for a = 1, blocks.numChildren, 1 do
		if(collisionRect.y - 10> blocks[a].y - 170 and blocks[a].x - 40 < collisionRect.x and blocks[a].x + 40 > collisionRect.x) then
			--stop the monster
			speed = 0
			monster.isAlive = false
			--this simply pauses the current animation
			monster:pause()
			gameOver.x = display.contentWidth*.65
			gameOver.y = display.contentHeight/2
			yesButton.x = display.contentWidth*.65 - 80
			yesButton.y = display.contentHeight/2 + 40
			noButton.x = display.contentWidth*.65 + 80
			noButton.y = display.contentHeight/2 + 40
		end
	end

	--stop the game if the monster runs into a spike wall
	for a = 1, spikes.numChildren, 1 do
		if(spikes[a].isAlive == true) then
			if(collisionRect.y - 10> spikes[a].y - 170 and spikes[a].x - 40 < collisionRect.x and spikes[a].x + 40 > collisionRect.x) then
				--stop the monster
				speed = 0
				monster.isAlive = false
				--this simply pauses the current animation
				monster:pause()
				gameOver.x = display.contentWidth*.65
				gameOver.y = display.contentHeight/2
				yesButton.x = display.contentWidth*.65 - 80
				yesButton.y = display.contentHeight/2 + 40
				noButton.x = display.contentWidth*.65 + 80
				noButton.y = display.contentHeight/2 + 40
			end
		end
	end

	--make sure the player didn't get hit by a ghost!
	for a = 1, ghosts.numChildren, 1 do
		if(ghosts[a].isAlive == true) then
			if(((  ((monster.y-ghosts[a].y))<70) and ((monster.y - ghosts[a].y) > -70)) and (ghosts[a].x - 40 < collisionRect.x and ghosts[a].x + 40 > collisionRect.x)) then
				--stop the monster
				speed = 0
				monster.isAlive = false
				--this simply pauses the current animation
				monster:pause()
				gameOver.x = display.contentWidth*.65
				gameOver.y = display.contentHeight/2
				yesButton.x = display.contentWidth*.65 - 80
				yesButton.y = display.contentHeight/2 + 40
				noButton.x = display.contentWidth*.65 + 80
				noButton.y = display.contentHeight/2 + 40
			end
		end
	end

	--make sure the player didn't get hit by the boss's spit!
	for a = 1, bossSpits.numChildren, 1 do
		if(bossSpits[a].isAlive == true) then
			--if(((  ((monster.y-bossSpits[a].y))<50) and ((monster.y-bossSpits[a].y))>0) and ((  ((monster.x-bossSpits[a].x))<50) and ((monster.x-bossSpits[a].x))>0)) then
			if(((  ((monster.y-bossSpits[a].y))<45)) and ((  ((monster.y-bossSpits[a].y))>-45)) and ((  ((monster.x-bossSpits[a].x))>-45)) ) then --(bossSpits[a].x - 5 < collisionRect.x and bossSpits[a].x + 5 > collisionRect.x)) then
				--stop the monster
				speed = 0
				monster.isAlive = false
				--this simply pauses the current animation
				monster:pause()
				gameOver.x = display.contentWidth*.65
				gameOver.y = display.contentHeight/2
				yesButton.x = display.contentWidth*.65 - 80
				yesButton.y = display.contentHeight/2 + 40
				noButton.x = display.contentWidth*.65 + 80
				noButton.y = display.contentHeight/2 + 40
			end
		end
	end

	for a = 1, blocks.numChildren, 1 do
		if(monster.y >= blocks[a].y - 170 and blocks[a].x < monster.x + 60 and blocks[a].x > monster.x - 60) then
			monster.y = blocks[a].y - 171
			onGround = true
			break
		else
			onGround = false
		end
	end
end

--update the ghosts if they are alive
function updateGhosts()
	for a = 1, ghosts.numChildren, 1 do
		if(ghosts[a].isAlive == true) then
			(ghosts[a]):translate(speed * -1, 0)
			if(ghosts[a].y > monster.y) then
				ghosts[a].y = ghosts[a].y - 1
			end
			if(ghosts[a].y < monster.y) then
				ghosts[a].y = ghosts[a].y + 1
			end
			if(ghosts[a].x < -80) then
				ghosts[a].x = 800
				ghosts[a].y = 600
				ghosts[a].speed = 0
				ghosts[a].isAlive = false;
			end
		end
    end
end

--check to see if the spikes are alive or not, if they are
--then update them appropriately
function updateSpikes()
    for a = 1, spikes.numChildren, 1 do
        if(spikes[a].isAlive == true) then
            (spikes[a]):translate(speed * -1, 0)
            if(spikes[a].x < -80) then
                spikes[a].x = 900
                spikes[a].y = 500
                spikes[a].isAlive = false
            end
        end
    end
end

function updateBlasts()
        --for each blast that we instantiated check to see what it is doing
    for a = 1, blasts.numChildren, 1 do
                --if that blast is not in play we don't need to check anything else
        if(blasts[a].isAlive == true) then
            (blasts[a]):translate(5, 0)
                        --if the blast has moved off of the screen, then kill it and return it to its original place
            if(blasts[a].x > 550) then
                    blasts[a].x = 800
                blasts[a].y = 500
                blasts[a].isAlive = false
            end
        end
                --check for collisions between the blasts and the spikes
        for b = 1, spikes.numChildren, 1 do
            if(spikes[b].isAlive == true) then
                if(blasts[a].y - 25 > spikes[b].y - 120 and blasts[a].y + 25 < spikes[b].y + 120 and spikes[b].x - 40 < blasts[a].x + 25 and spikes[b].x + 40 > blasts[a].x - 25) then
					blasts[a].x = 800
					blasts[a].y = 500
					blasts[a].isAlive = false
					spikes[b].x = 900
					spikes[b].y = 500
					spikes[b].isAlive = false
                end
            end
        end

		--check for collisions between the blasts and the ghosts
		for b = 1, ghosts.numChildren, 1 do
			if(ghosts[b].isAlive == true) then
				if(blasts[a].y - 25 > ghosts[b].y - 120 and blasts[a].y + 25 < ghosts[b].y + 120 and ghosts[b].x - 40 < blasts[a].x + 25 and ghosts[b].x + 40 > blasts[a].x - 25) then
					blasts[a].x = 800
					blasts[a].y = 500
					blasts[a].isAlive = false
					ghosts[b].x = 800
					ghosts[b].y = 600
					ghosts[b].isAlive = false
					ghosts[b].speed = 0
				end
            end
        end

		--check for collisions with the boss
		if(boss.isAlive == true) then
			if(blasts[a].y - 25 > boss.y - 120 and blasts[a].y + 25 < boss.y + 120 and boss.x - 40 < blasts[a].x + 25 and boss.x + 40 > blasts[a].x - 25) then
				blasts[a].x = 800
				blasts[a].y = 500
				blasts[a].isAlive = false
				boss.health = boss.health - 1
			end
		end

		--check for collisions between the blasts and the bossSpit
		for b = 1, bossSpits.numChildren, 1 do
			if(bossSpits[b].isAlive == true) then
				if(blasts[a].y - 20 > bossSpits[b].y - 120 and blasts[a].y + 20 < bossSpits[b].y + 120 and bossSpits[b].x - 25 < blasts[a].x + 20 and bossSpits[b].x + 25 > blasts[a].x - 20) then
					blasts[a].x = 800
					blasts[a].y = 500
					blasts[a].isAlive = false
					bossSpits[b].x = 400
					bossSpits[b].y = 550
					bossSpits[b].isAlive = false
					bossSpits[b].speed = 0
				end
            end
        end

    end
end

function updateMonster()
     --if our monster is jumping then switch to the jumping animation
     --if not keep playing the running animation
     if(monster.isAlive == true) then
          if(onGround) then
               if(wasOnGround) then

               else
                    monster:prepare("running")
                    monster:play()
               end
          else
               monster:prepare("jumping")
               monster:play()
          end
          if(monster.accel > 0) then
               monster.accel = monster.accel - 1
          end
          monster.y = monster.y - monster.accel
          monster.y = monster.y - monster.gravity
     else
          monster:rotate(5)
     end
     --update the collisionRect to stay in front of the monster
     collisionRect.y = monster.y
end

function restartGame()
     --move menu
     gameOver.x = 0
     gameOver.y = 500
     --reset the score
     score = 0
     --reset the game speed
     speed = 5
     --reset the monster
     monster.isAlive = true
     monster.x = 60
     monster.y = 200
     monster:prepare("running")
     monster:play()
     monster.rotation = 0
     --reset the groundLevel
     groundLevel = groundMin
     for a = 1, blocks.numChildren, 1 do
          blocks[a].x = (a * 79) - 79
          blocks[a].y = groundLevel
     end
     --reset the ghosts
     for a = 1, ghosts.numChildren, 1 do
          ghosts[a].x = 800
          ghosts[a].y = 600
     end
     --reset the spikes
     for a = 1, spikes.numChildren, 1 do
          spikes[a].x = 900
          spikes[a].y = 500
     end
     --reset the blasts
     for a = 1, blasts.numChildren, 1 do
          blasts[a].x = 800
          blasts[a].y = 500
     end
     --reset the backgrounds
     backgroundfar.x = 480
     backgroundfar.y = 160
     backgroundnear1.x = 240
     backgroundnear1.y = 160
     backgroundnear2.x = 760
     backgroundnear2.y = 160

	 --reset the boss
	 boss.isAlive = false
	 boss.x = 300
	 boss.y = 550

	 --reset the boss's spit
     for a = 1, bossSpits.numChildren, 1 do
          bossSpits[a].x = 400
          bossSpits[a].y = 550
		  bossSpits[a].isAlive = false
     end

	 noButton.x = 100
	 noButton.y = 600
	 yesButton.x = 100
	 yesButton.y = 600
end

--the only difference in the touched function is now if you touch the
--right side of the screen the monster will fire off a little blue bolt
function touched( event )
if(monster.isAlive == true) then
    if(event.phase == "began") then
        if(event.x < 241) then
            if(onGround) then
                monster.accel = monster.accel + 20
            end
            else
                for a=1, blasts.numChildren, 1 do
                    if(blasts[a].isAlive == false) then
                        blasts[a].isAlive = true
                        blasts[a].x = monster.x + 50
                        blasts[a].y = monster.y
                        break
                    end
                end
            end
        end
    end
end

function noListener(event)
    director:changeScene( "menu", "downFlip" )
    return true
end

function yesListener(event)
    restartGame()
    return true
end

function updateSpeed()
	if(monster.isAlive) then
		speed = speed + .0005
	end
end

function updateBlocks()
     for a = 1, blocks.numChildren, 1 do
          if(a > 1) then
               newX = (blocks[a - 1]).x + 79
          else
               newX = (blocks[8]).x + 79 - speed
          end
          if((blocks[a]).x < -40) then
		    if (boss.isAlive == false) then
				score = score + 1
				scoreText.text = "score: " .. score
				scoreText:setReferencePoint(display.CenterLeftReferencePoint)
				scoreText.x = 0
				scoreText.y = 30
			else
				boss.spitCycle = boss.spitCycle + 1
				if(boss.y > 100 and boss.y < 300 and boss.spitCycle%3 == 0) then
					for a=1, bossSpits.numChildren, 1 do
						if(bossSpits[a].isAlive == false) then
							bossSpits[a].isAlive = true
							bossSpits[a].x = boss.x - 35
							bossSpits[a].y = boss.y + 55
							print(bossSpits[a].y .. "::" .. boss.y)
							bossSpits[a].speed = math.random(5,10)
							break
						end
					end
				end
			end
			 if(inEvent == 11) then
				  (blocks[a]).x, (blocks[a]).y = newX, 600
			 else
				  (blocks[a]).x, (blocks[a]).y = newX, groundLevel
			 end
			--by setting up the spikes this way we are guaranteed to
			--only have 3 spikes out at most at a time.
			if(inEvent == 12) then
				for a=1, spikes.numChildren, 1 do
					if(spikes[a].isAlive == true) then
					--do nothing
					else
					spikes[a].isAlive = true
					spikes[a].y = groundLevel - 200
					spikes[a].x = newX
					break
					end
				end
			end

			if(inEvent == 15) then
				groundLevel = groundMin
			end

			 checkEvent()
			else
				 (blocks[a]):translate(speed * -1, 0)
			end
		 end
end

function checkEvent()
     --first check to see if we are already in an event, we only want 1 event going on at a time
     if(eventRun > 0) then
          eventRun = eventRun - 1
          if(eventRun == 0) then
               inEvent = 0
          end
     end
     --if we are in an event then do nothing
     if(inEvent > 0 and eventRun > 0) then
          --Do nothing
     else
		if(boss.isAlive == false and score%10 == 0) then
			boss.isAlive = true
			boss.x = 400
			boss.y = -200
			boss.health = 10
		end
		if(boss.isAlive == true) then
			inEvent = 15
		else
		  check = math.random(100)
		  if(check > 80 and check < 99) then
			   inEvent = math.random(10)
			   eventRun = 1
		  end

		  if(check > 98) then
				 inEvent = 11
				 eventRun = 2
			end
			--the more frequently you want events to happen then
			--greater you should make the checks
			if(check > 72 and check < 81) then
					inEvent = 12
					eventRun = 1
			end

			--ghost event
			if(check > 60 and check < 73) then
					inEvent = 13
					eventRun = 1
			end
		end
     end
     --if we are in an event call runEvent to figure out if anything special needs to be done
     if(inEvent > 0) then
          runEvent()
     end
end

function runEvent()
     if(inEvent < 6) then
          groundLevel = groundLevel + 40
     end
     if(inEvent > 5 and inEvent < 11) then
          groundLevel = groundLevel - 40
     end
     if(groundLevel < groundMax) then
          groundLevel = groundMax
     end
     if(groundLevel > groundMin) then
          groundLevel = groundMin
     end

	--this will be a little bit different as we want this to really
	--make the game feel even more random. change where the ghosts
	--spawn and how fast they come at the monster.
	--this will be a little bit different as we want this to really
	--make the game feel even more random. change where the ghosts
	--spawn and how fast they come at the monster.
if(inEvent == 13) then
	for a=1, ghosts.numChildren, 1 do
		if(ghosts[a].isAlive == false) then
			ghosts[a].isAlive = true
			ghosts[a].x = 500
			ghosts[a].y = math.random(-50, 400)
			ghosts[a].speed = math.random(2,4)
			break
			end
		end
	end
end

function updateBackgrounds()
	--far background movement
	backgroundfar.x = backgroundfar.x - (speed/55)

	--near background movement
	backgroundnear1.x = backgroundnear1.x - (speed/5)
	if(backgroundnear1.x < -239) then
		backgroundnear1.x = 760
	end

	backgroundnear2.x = backgroundnear2.x - (speed/5)
	if(backgroundnear2.x < -239) then
		backgroundnear2.x = 760
	end
end

timer.performWithDelay(1, update, -1)
Runtime:addEventListener("touch", touched, -1)
yesButton:addEventListener("touch", yesListener )
noButton:addEventListener("touch", noListener )
    return gameDisplay
end