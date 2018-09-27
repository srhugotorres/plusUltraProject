local newGamepad = require("scripts.elements.gamepad")
-- Físicas
local physics = require("physics")
physics.start()
physics.setGravity(0,0)

local ship = {}

function ship.new(mainGroup)
    local instance = {}
    -- Atributos
    instance.group = mainGroup
    instance.style = "assets/style/Contemporary/ship/ship.png"
    instance.bulletStyle = "assets/style/Contemporary/ship/fireball.png"
    instance.shipMoveX = 0
    instance.speed = 6
    instance.ship = display.newImageRect (instance.style,70,96)
        instance.ship.x = display.contentCenterX
        instance.ship.y = (display.contentCenterY) * 1.65 
        instance.ship.rotation = - 90
        instance.ship.myName = "ship"
    physics.addBody(instance.ship, "static", {radius=50, isSensor=true});
    instance.gamepad = newGamepad.new()
    -- Método
    function instance.fireBallShoot()
        print("atirou")
        instance.bullet = display.newImageRect(instance.group,instance.bulletStyle,30,30)
        print(instance.bullet)
        physics.addBody(instance.bullet,"dynamic",{isSensor=true})
        instance.bullet.isBullet = true
        instance.bullet.myName = "bullet"
        instance.bullet.x = instance.ship.x
        instance.bullet.y = instance.ship.y
        instance.bullet:toBack()
        transition.to(
            instance.bullet,
            {
                y = -40,
                time = 500,
                onComplete = function()
                    display.remove(instance.bullet)
                end
            }
        )

    end
    
    function instance.getMoveX()
        return instance.shipMoveX
    end
    function instance.setMoveX(moveX)
        instance.shipMoveX = moveX
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
    function instance.createEdges(event)
        if instance.ship.x < 0 then
            instance.ship.x = 0
        end
        if instance.ship.x > display.contentWidth - 1 then
            instance.ship.x = display.contentWidth - 1
        end
    end
    --Gamepad
    function instance.getGamepad()
        return instance.gamepad
    end
    function instance.shoot()
        print("apertou o botão")
        return instance.gamepad.getShootButton()
    end
    function instance.moveLeft()
        return instance.gamepad.getLeftArrow()
    end
    function instance.moveRight()
        return instance.gamepad.getRightArrow()
    end
    function instance.stopShip(event)
        if event.phase == "ended" then
            instance.shipMoveX = 0
        end
    end
    function instance.moveShip(event)
        instance.ship.x = instance.ship.x + instance.shipMoveX
    end
   
    function instance.leftArrowtouch()
        instance.shipMoveX = - instance.speed
    end
    function instance.rightArrowtouch()
        instance.shipMoveX =  instance.speed
    end
     --[[
         ]]--
    instance.moveLeft():addEventListener("touch", instance.leftArrowtouch)
    instance.moveRight():addEventListener ("touch", instance.rightArrowtouch)
    instance.shoot():addEventListener("touch",instance.fireBallShoot)
    Runtime:addEventListener("enterFrame", instance.moveShip)
    Runtime:addEventListener("touch", instance.stopShip)
    Runtime:addEventListener("enterFrame", instance.createEdges)
    -- Gamepad
    
    --Runtime:addEventListener("enterFrame", instance.moveShip)
    --Runtime:addEventListener("touch", instance.stopShip)
    return instance
end


return ship