
local newGamepadTouch = require "scripts.elements.gamepadtouch"
local newKeyboard = require "scripts.keyboard"

local controller = {}

function controller.runGamepadTouch(ship)
    local gamepad = newGamepadTouch.new()
    gamepad.getLeftArrow():addEventListener("touch",ship.moveLeft)
    gamepad.getRightArrow():addEventListener("touch",ship.moveRight)
    gamepad.getShootButton():addEventListener("touch",ship.bullet)
    Runtime:addEventListener("touch", ship.stopShip)
    Runtime:addEventListener("enterFrame", ship.moveShip)
    Runtime:addEventListener("enterFrame", ship.createEdges)
end
--[[
function controller.runKeyboard(keyboard,ship)
    keyboard.run(ship)
end
function controller.run(ship)
    local gamepad  =  newGamepad.new()
    local keyboard =  newKeyboard

    --controller.runGamepad(gamepad,ship)
    controller.runKeyboard(keyboard,ship)
end
]]--
function controller.runKeyboard(ship)
    newKeyboard.new(ship)
    --Runtime:addEventListener("key",newKeyboard.run)
    Runtime:addEventListener("key",newKeyboard.run)
    timer.performWithDelay( 5, function()  Runtime:addEventListener("key", ship.stopShip) end )
    Runtime:addEventListener("enterFrame", ship.moveShip)
    Runtime:addEventListener("enterFrame", ship.createEdges)
end
return controller