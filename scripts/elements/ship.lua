local newGamepad = require("scripts.elements.gamepad")
-- Físicas
local physics = require("physics")
physics.start()
physics.setGravity(0,0)

local ship = {}

function ship.new()
    local instance = {}
    -- Atributos
    instance.style = "assets/style/Contemporary/ship/ship.png"
    instance.bulletStyle = "assets/style/Contemporary/ship/fireball.png"
    instance.moveX = 0
    instance.ship = display.newImageRect (instance.style,70,96)
        instance.speed = 6
        instance.ship.x = display.contentCenterX
        instance.ship.y = (display.contentCenterY) * 1.65 
        instance.ship.rotation = - 90
        instance.ship.myName = "ship"
    physics.addBody(instance.ship, "static", {radius=50, isSensor=true});
    instance.gamepad = newGamepad.new()
    -- Método
    function instance.singleShoot()
        instance.bullet = display.newImageRect(instance.bulletStyle,30,30)
        physics.addBody(instance.bullet,"dynamic",{isSensor=true})
        instance.bullet.isBullet = true
        instance.bullet.myName = "bullet"
        instance.bullet.x = instance.ship.x
        instance.bullet.y = instance.ship.y
        instance.bullet.toBack()
        transition.to(
            instance.bullet,{
                y = -40,
                time = 500,
                onComplete = function()
                    display.remove(instance.bullet)
                end
            }
        )

    end
    function instance.getMoveX()
        return instance.moveX
    end
    function instance.setMoveX(moveX)
        instance.moveX = moveX
    end
    function instance.getPositionX()
        return instance.ship.x
    end
    function instance.setPositionX(shipX)
        instance.ship.x =shipX
    end
    function instance.getPositionY()
        return instance.ship.y
    end
    function instance.setPositionY(shipY)
        instance.ship.x =shipY
    end
    function instance.getShipName()
        return instance.ship.myName
    end
    function instance.printMyName()
        print(instance.ship.myName)
    end
    function instance.getSpeed()
        return instance.speed
    end
    function instance.getGamepad()
        return instance.gamepad
    end
    function instance.moveLeft()
        return instance.gamepad.getLeftArrow()
    end
    function instance.moveRight()
        return instance.gamepad.getRightArrow()
    end
    --[[
    function instance.stopShip(event)
        if event.phase == "ended" then
            instance.moveX = 0
        end
    end
    function instance.moveShip()
        instance.ship.x = instance.ship.x + instance.moveX
    end
    function instance.leftArrowtouch()
        instance.ship.x = instance.ship.x - instance.speed
    end
    function instance.rightArrowtouch()
        instance.ship.x = - instance.speed
    end
    ]]--
    
    -- Gamepad
    
    --Runtime:addEventListener("enterFrame", instance.moveShip)
    --Runtime:addEventListener("touch", instance.stopShip)
    return instance
end

return ship