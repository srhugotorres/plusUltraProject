display.setStatusBar(display.HiddenStatusBar)
local centerWidth = display.contentCenterX
local centerHeight = display.contentCenterY

-- Físicas
local physics = require("physics")
physics.start()
physics.setGravity(0,0)

-- Variáveis global
local shipMoveY = 0
local ship 
local speed = 6 

-- Funções Global
local createShip

-- Background 
local background = display.newImage("images/spacebackground.png")
	background.x = centerWidth
    background.y = centerHeight

-- Definindo botões do gamepad
local leftArrow = display.newImage("images/left.png")
    leftArrow.x = 50
    leftArrow.y = 100
local rightArrow = display.newImage("images/right.png")
    rightArrow.x = 50
    rightArrow.y = 300

-- Criando gamepad
local function stopShip(event)
    if event.phase == "ended" then
        shipMoveY = 0 
    end
end

local function moveShip(event)
    ship.y = ship.y + shipMoveY
end


function leftArrowtouch()
    shipMoveY = - speed
end


function rightArrowtouch()
    shipMoveY = speed
end

function createShip()
    ship = display.newImage ("images/ship.png")
    physics.addBody(ship, "static", {density = 1, friction = 0, bounce = 0});
    ship.x = 150
    ship.y = display.contentCenterY
    ship.myName = "ship"
end

-- Núcleo do jogo
function startGame()
    createShip()
    
    rightArrow:addEventListener ("touch", rightArrowtouch)
    leftArrow:addEventListener("touch", leftArrowtouch)
    Runtime:addEventListener("enterFrame", moveShip)
    Runtime:addEventListener("touch", stopShip)
    
end
    
startGame()
    