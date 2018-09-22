local composer = require( "composer" )
 
local scene = composer.newScene()

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
local shipMoveX = 0
local ship 
local speed = 6

local asteroidsTable ={}
local arrowAjust = 0.586510264

-- Funções Global
local function createShip()
    ship = display.newImageRect (mainGroup,"images/ship.png",70,96)
    physics.addBody(ship, "static", {radius=50, isSensor=true});
    ship.x = display.contentCenterX
    ship.y = (display.contentCenterY) * 1.65 
    ship.rotation = -90
    ship.myName = "ship"
end

local function createEdges(event)	
    if ship.x < 0 then
       ship.x = 0
    end
    if ship.x > display.contentWidth - 1 then
       ship.x = display.contentWidth - 1
    end
end

-- Criando gamepad
local function stopShip(event)
    if event.phase == "ended" then
        shipMoveX = 0 
    end
end

local function moveShip(event)
    ship.x = ship.x + shipMoveX
end


function leftArrowtouch()
    shipMoveX = - speed
end


function rightArrowtouch()
    shipMoveX = speed
end
-- Asteroid
local function createAsteroid()

	local asteroid = display.newImageRect(mainGroup,"images/asteroid.png", 150, 150)
	   	table.insert( asteroidsTable, asteroid)
	   	physics.addBody( asteroid, "dynamic", { radius=48, bounce=0.8 } )
	   	asteroid.myName = "asteroid"

   	local whereFrom = math.random(2)
        if ( whereFrom == 1 ) then
	        asteroid.x = math.random(display.contentCenterX + 10,display.contentCenterX + 800)
            asteroid.y = display.contentCenterY  - 300
            asteroid:setLinearVelocity(0, 88)
        

        elseif ( whereFrom == 2 ) then
	        asteroid.x = math.random(display.contentCenterX)
            asteroid.y = display.contentCenterY  - 300
            asteroid:setLinearVelocity(0, 88)
        

        
		end
	asteroid:applyTorque( math.random( -6,6 ) )
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

        if ( ( obj1.myName == "ship" and obj2.myName == "asteroid" ) or ( obj1.myName == "asteroid" and obj2.myName == "ship" ) ) then
                died = true
                ship.alpha = 0
                composer.gotoScene("gameover")

        end
     end
end



local function asteroidGenerator()
    createAsteroid()
    for i = #asteroidsTable, 1, -1 do
        local thisAsteroid = asteroidsTable[i]
 
        if ( thisAsteroid.x < -100 or
             thisAsteroid.x > display.contentWidth + 100 or
             thisAsteroid.y < -100 or
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
    local background = display.newImageRect(backGroup,"images/spacebackground.png", 1536,2048)
        background.x = centerWidth
        background.y = centerHeight

    local leftArrow = display.newImageRect(uiGroup,"images/arrow.png",80,80)
        leftArrow.x = (display.screenOriginX * arrowAjust)
        leftArrow.y = display.contentCenterY * 1.8
        leftArrow.rotation = -90
    local rightArrow = display.newImage(uiGroup,"images/arrow.png",80,80)
        rightArrow.x = 	-(display.screenOriginX * arrowAjust)
        rightArrow.y = display.contentCenterY * 1.8
        rightArrow.rotation = 90
    
    -- Núcleo do jogo
    function startGame()
    
        createShip()
        timer.performWithDelay( 500, asteroidGenerator, 0 )
        rightArrow:addEventListener ("touch", rightArrowtouch)
        leftArrow:addEventListener("touch", leftArrowtouch)
        Runtime:addEventListener("enterFrame", moveShip)
        Runtime:addEventListener("touch", stopShip)
        Runtime:addEventListener("enterFrame", createEdges)
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
