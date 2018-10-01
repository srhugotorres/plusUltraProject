local composer = require( "composer" )
local scene = composer.newScene()
local newShip = require("scripts.elements.ship")
local newAsteroid = require("scripts.elements.asteroid")
local backGroup = display.newGroup()
local mainGroup = display.newGroup()
local uiGroup = display.newGroup()
local centerWidth = display.contentCenterX
local centerHeight = display.contentCenterY

-- Asteroid
local newAsteroid = require("scripts.elements.asteroid")

-- Físicas
local physics = require("physics")
physics.start()
physics.setGravity(0,0)

-- Variáveis global

local asteroidsTable = {}



-- Funções Global
function scrollSky(self,event)
    if self.y > 800 then
        self.y = 0.1
    else
        self.y = self.y + self.speed
    end
end

local ship = newShip.new(mainGroup)


local asteroid = newAsteroid.new(mainGroup,asteroidsTable)

function onCollision( event )

    if  event.phase == "began"  then

        local obj1 = event.object1
        local obj2 = event.object2
    end

    if  event.phase == "began"  then

        local obj1 = event.object1
        local obj2 = event.object2
        if  obj1.myName == "ship" and  obj2.myName == "asteroid"
            or obj1.myName == "asteroid" and  obj2.myName ==  "ship" then

            died = true
            ship.getShip().alpha = 0
            composer.gotoScene("scripts.gameover")
        --[[
            ]]--
        elseif obj1.myName == "bullet" and  obj2.myName == "asteroid"
        or obj1.myName == "asteroid" and  obj2.myName ==  "bullet"  then

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
    newAsteroid.new(mainGroup,asteroidsTable)
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

function scene:create( event )
 
    local sceneGroup = self.view

    -- Background 
    local background = display.newImageRect(backGroup,"assets/style/Contemporary/background/spacebackground.png",2732,2048 )
        background.rotation = -90
        background.speed = 0.5
        background.x = centerWidth
        background.y = centerHeight

    -- Núcleo do jogo
    function startGame()
        
        background.enterFrame = scrollSky
        Runtime:addEventListener("enterFrame",background)
        timer.performWithDelay( 500, asteroidGenerator, 0 )
        Runtime:addEventListener( "collision", onCollision )

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
