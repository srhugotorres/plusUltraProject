
local controller = {}
function controller.new(
    ship,
    commandLeft,
    commandRight,
    commandShoot,
    commandEvent
)
    commandLeft():addEventListener(commandEvent,ship.moveLeft)
    commandRight():addEventListener(commandEvent,ship.moveRight)
    commandShoot():addEventListener(commandEvent,ship.bullet)
    Runtime:addEventListener(commandEvent, ship.stopShip)
    Runtime:addEventListener("enterFrame", ship.moveShip)
    Runtime:addEventListener("enterFrame", ship.createEdges)
end
function controller.runGamepad(gamepad,ship)
    controller.new(
        ship,
        gamepad.getLeftArrow,
        gamepad.getRightArrow,
        gamepad.getShootButton,
        "touch"
    )
end
--[[
function controller.runKeyboard(ship,event)
        controller.new(
            event.keyName == "left",
            event.keyName == "right",
            event.keyName == "z",
            ship,
            "key"
        )
        
    end
]]--
return controller