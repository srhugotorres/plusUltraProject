local composer = require( "composer" )
local newGamepad = require("scripts.elements.gamepad")
local scene = composer.newScene()
local newShip = require("scripts.elements.ship")
local backGroup = display.newGroup()
local mainGroup = display.newGroup()
local uiGroup = display.newGroup()
local centerWidth = display.contentCenterX
local centerHeight = display.contentCenterY


-- Físicas
local physics = require("physics")
physics.start()
physics.setGravity(0,0)

-- Variáveis global
--[[
local shipMoveX = 0
local ship 
local speed = 6
]]--
local asteroidsTable = {}

--local arrowAjust = 0.586510264

-- Funções Global
function scrollSky(self,event)
    if self.y > 800 then
        self.y = 0.1
    else
        self.y = self.y + self.speed
    end
end

--[[
local function createShip()
    ship = display.newImageRect (mainGroup,"assets/style/Contemporary/ship/ship.png",70,96)
    physics.addBody(ship, "static", {radius=50, isSensor=true});
    ship.x = display.contentCenterX
    ship.y = (display.contentCenterY) * 1.65 
    ship.rotation = -90
    ship.myName = "ship"
end
local function fireBallShoot()
    local fireBall = display.newImageRect(mainGroup,"assets/style/Contemporary/ship/fireball.png",30,30)
    physics.addBody(fireBall,"dynamic",{isSensor=true})
    fireBall.isBullet = true
    fireBall.myName = "fireball"
    fireBall.x = ship.x
    fireBall.y = ship.y
    fireBall:toBack()
    transition.to(
        fireBall,{
            y=-40,
            time=500,
            onComplete = function() 
                display.remove(fireBall)
            end
        }
    )
end
]]--
local ship = newShip.new()

local function createEdges(event)	
    if ship.getPositionX() < 0 then
       ship.setPositionX(0)
    end
    if ship.getPositionX() > display.contentWidth - 1 then
       local newposition = display.contentWidth - 1
       ship.setPositionX(newposition)
    end
end

-- Criando gamepad
--[[
    ]]--
local function stopShip(event)
    if event.phase == "ended" then
        ship.setMoveX(0)
    end
end

local function moveShip(event)
    local newposition = ship.getPositionX() + ship.getMoveX()
    ship.setPositionX(newposition)
end


function leftArrowtouch()
    local moveX = ship.getMoveX() - ship.getSpeed()
    ship.setMoveX(moveX)
end


function rightArrowtouch()
    local MoveX = ship.getMoveX() + ship.getSpeed()
    ship.setMoveX(MoveX)
end
local gamepad = newGamepad.new()
--[[
-- Asteroid
local function createAsteroid()
    local asteroidRandom
    local smallAsteroid = display.newImageRect(mainGroup,"assets/style/Contemporary/asteroids/small/c40007.png",64,64)
        table.insert( asteroidsTable, smallAsteroid )
        physics.addBody(smallAsteroid,"dynamic", { radius=22, bounce=0.8 })
        smallAsteroid.myName = "smallAsteroid"
    local mediumAsteroid = display.newImageRect(mainGroup,"assets/style/Contemporary/asteroids/medium/c40000.png", 120,120)
        table.insert( asteroidsTable,mediumAsteroid )
        physics.addBody(mediumAsteroid,"dynamic",{radius=33, bounce=0.8})
        mediumAsteroid.myName = "mediumAsteroid"
	local largeAsteroid = display.newImageRect(mainGroup,"assets/style/Contemporary/asteroids/large/c10015.png", 210, 130)
        table.insert( asteroidsTable, largeAsteroid)
        physics.addBody( largeAsteroid, "dynamic", { radius=48, bounce=0.8 } )
        largeAsteroid.myName = "largeAsteroid"
    local asteroidChooser = math.random(6)
        if(asteroidChooser == 1 or asteroidChooser == 2 or asteroidChooser == 3 ) then
            asteroidRandom = smallAsteroid
        elseif(asteroidChooser == 4 or asteroidChooser == 5) then
            asteroidRandom = mediumAsteroid

        elseif(asteroidChooser == 6) then
            asteroidRandom = largeAsteroid
        end

    local whereFrom = math.random(3)

        if ( whereFrom == 1 ) then
	        asteroidRandom.x = math.random(display.contentCenterX + 20,display.contentCenterX + 300)
            asteroidRandom.y = display.contentCenterY  - 400
            asteroidRandom:setLinearVelocity(0, 88)
        elseif ( whereFrom == 2 ) then
	        asteroidRandom.x = math.random(display.contentCenterX+ 30, display.contentCenterX + 500)
            asteroidRandom.y = display.contentCenterY  - 400
            asteroidRandom:setLinearVelocity(0, 88)
        elseif ( whereFrom == 3 ) then
	        asteroidRandom.x = math.random(display.contentCenterX + 50,display.contentCenterX + 1000)
            asteroidRandom.y = display.contentCenterY  - 400
            asteroidRandom:setLinearVelocity(0, 88)
		end
	asteroidRandom:applyTorque( math.random( -6,6 ) )
end
local function createEdges(event)	
    if ship.x < 0 then
       ship.x = 0
    end
    if ship.x > display.contentWidth - 1 then
       ship.x = display.contentWidth - 1
    end
end

local function onCollision( event )

    if ( event.phase == "began" ) then

        local obj1 = event.object1
        local obj2 = event.object2
    end

    if ( event.phase == "began" ) then

        local obj1 = event.object1
        local obj2 = event.object2

        if ( 
            ( obj1.myName == "ship" and (
                obj2.myName == "smallAsteroid" or obj2.myName == "mediumAsteroid" or obj2.myName == "largeAsteroid") ) 
                or ( (obj1.myName == "smallAsteroid" or obj2.myName == "mediumAsteroid" or obj1.myName == "largeAsteroid") and obj2.myName == "ship" ) ) then
                died = true
                ship.alpha = 0
                composer.gotoScene("scripts.gameover")

        elseif (obj1.myName == "fireball" and (
            obj2.myName == "smallAsteroid" or obj2.myName == "mediumAsteroid" or obj2.myName == "largeAsteroid") )
            or ((obj1.myName == "smallAsteroid" or obj2.myName == "mediumAsteroid" or obj1.myName == "largeAsteroid") and obj2.myName == "ship" ) then
                display.remove( obj1 )
                display.remove( obj2 )
 
                for i = #asteroidsTable, 1, -1 do
                    if ( asteroidsTable[i] == obj1 or asteroidsTable[i] == obj2 ) then
                        table.remove( asteroidsTable, i )
                        break
                    end
                end
        end
     end
end

local function asteroidGenerator()
    createAsteroid()
    for i = #asteroidsTable, 1, -1 do
        local thisAsteroid = asteroidsTable[i]
 
        if ( thisAsteroid.x < -300 or
             thisAsteroid.x > display.contentWidth + 100 or
             thisAsteroid.y < -300 or
             thisAsteroid.y > display.contentHeight + 100 )
        then
            display.remove( thisAsteroid )
            table.remove( asteroidsTable, i )
        end
    end
end
]]--
function scene:create( event )
 
    local sceneGroup = self.view

    -- Background 
    local background = display.newImageRect(backGroup,"assets/style/Contemporary/background/spacebackground.png",2732,2048 )
        background.rotation = -90
        background.speed = 0.5
        background.x = centerWidth
        background.y = centerHeight
--[[
    local leftArrow = display.newImageRect(uiGroup,"assets/gamepad/arrow.png",80,80)
        leftArrow.x = (display.screenOriginX * arrowAjust)
        leftArrow.y = display.contentCenterY * 1.8
        leftArrow.rotation = -90

    local rightArrow = display.newImage(uiGroup,"assets/gamepad/arrow.png",80,80)
        rightArrow.x = 	-(display.screenOriginX * arrowAjust)
        rightArrow.y = display.contentCenterY * 1.8
        rightArrow.rotation = 90
        local shootButton = display.newImageRect(uiGroup,"assets/gamepad/shootButton.png",80,80)
        shootButton.x = display.screenOriginX +  1250
        shootButton.y = display.contentCenterY * 1.8
        ]]--

    -- Núcleo do jogo
    function startGame()

        background.enterFrame = scrollSky
        Runtime:addEventListener("enterFrame",background)
        --timer.performWithDelay( 500, asteroidGenerator, 0 )
        gamepad.getRightArrow():addEventListener ("touch", rightArrowtouch)
        gamepad.getLeftArrow():addEventListener("touch", leftArrowtouch)
        --shootButton:addEventListener("touch",fireBallShoot)
        Runtime:addEventListener("enterFrame", moveShip)
        Runtime:addEventListener("touch", stopShip)
        Runtime:addEventListener("enterFrame", createEdges)
        --Runtime:addEventListener( "collision", onCollision )

    end

    startGame()
end
 
 
-- show()
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
 
    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
 
    end
end
 
 
-- hide()
function scene:hide( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is on screen (but is about to go off screen)
 
    elseif ( phase == "did" ) then
        -- Code here runs immediately after the scene goes entirely off screen
 
    end
end
 
 
-- destroy()
function scene:destroy( event )
 
    local sceneGroup = self.view
    -- Code here runs prior to the removal of scene's view
 
end
 
 
-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------
 
return scene
