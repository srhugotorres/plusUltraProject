display.setStatusBar(display.HiddenStatusBar)
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

-- Funções Global
local createShip

-- Background 
local background = display.newImage("images/spacebackground.png")
	background.x = centerWidth
    background.y = centerHeight

-- Definindo botões do gamepad
local leftArrow = display.newImage("images/arrow.png")
    leftArrow.x = display.contentCenterX - 550 
    leftArrow.y = display.contentCenterY + 300
    leftArrow.rotation = -90
local rightArrow = display.newImage("images/arrow.png")
    rightArrow.x = display.contentCenterX - 400
    rightArrow.y = display.contentCenterY + 300
    rightArrow.rotation = 90

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

function createShip()
    ship = display.newImage ("images/ship.png")
    physics.addBody(ship, "static", {density = 1, friction = 0, bounce = 0});
    ship.x = display.contentCenterX
    ship.y = display.contentCenterY + 250
    ship.rotation = -90
    ship.myName = "ship"
end
-- Asteroid
local function createAsteroid()

	local newAsteroid = display.newImageRect("images/asteroidSmall.png", 150, 150)
	   	table.insert( {}, newAsteroid)
	   	physics.addBody( newAsteroid, "dynamic", { radius=70, bounce=0.8 } )
	   	newAsteroid.myName = "asteroid"

   	local whereFrom = math.random(1)
        if ( whereFrom == 1 ) then
	        newAsteroid.x = math.random(-20,display.contentCenterY+740)
            newAsteroid.y = display.contentCenterY  - 300
	        newAsteroid:setLinearVelocity(0, 100)
		end
	newAsteroid:applyTorque( math.random( -6,6 ) )
end

-- Núcleo do jogo
function startGame()
    
    createShip()
    createAsteroid()
    createAsteroid()
    createAsteroid()
    createAsteroid()
    createAsteroid()
    createAsteroid()
    createAsteroid()
    rightArrow:addEventListener ("touch", rightArrowtouch)
    leftArrow:addEventListener("touch", leftArrowtouch)
    Runtime:addEventListener("enterFrame", moveShip)
    Runtime:addEventListener("touch", stopShip)
    
end
    
startGame()
    