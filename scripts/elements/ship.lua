local newGamepad = require("scripts.elements.gamepad")
local newBullet = require("scripts.elements.bullet")

-- Físicas
local physics = require("physics")
physics.start()
physics.setGravity(0,0)
local shootName = "bullet"
local ship = {}

function ship.new(mainGroup)
    local instance = {}
    -- Atributos
    instance.group = mainGroup
    instance.style = "assets/style/Contemporary/ship/ship.png"
    instance.shipMoveX = 0
    instance.speed = 6
    instance.ship = display.newImageRect (mainGroup,instance.style,70,96)
        instance.ship.x = display.contentCenterX
        instance.ship.y = (display.contentCenterY) * 1.65 
        instance.ship.rotation = - 90
        instance.ship.myName = "ship"
    physics.addBody(instance.ship, "static", {radius=50, isSensor=true});
    instance.gamepad = newGamepad.new()
    -- Métodos
    function instance.setMyName(name)
        instance.ship.myName = name
    end
    function instance.bullet()
        if instance.ship.alpha ~= 0 then
            newBullet.new(instance.group,instance.ship.x,instance.ship.y)
        end
    end
    function instance.getShip()
        return instance.ship
    end
    function instance.getMoveX()
        return instance.shipMoveX
    end
    function instance.setMoveX(moveX)
        instance.shipMoveX = moveX
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

        return instance.gamepad.getShootButton()
    end
    function instance.moveLeft()
        if instance.ship.alpha ~= 0 then
            return instance.gamepad.getLeftArrow()
        end
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
    instance.moveLeft():addEventListener("touch", instance.leftArrowtouch)
    instance.moveRight():addEventListener ("touch", instance.rightArrowtouch)
    instance.shoot():addEventListener("touch",instance.bullet)
    Runtime:addEventListener("enterFrame", instance.moveShip)
    Runtime:addEventListener("touch", instance.stopShip)
    Runtime:addEventListener("enterFrame", instance.createEdges)
    -- Gamepad
    
    --Runtime:addEventListener("enterFrame", instance.moveShip)
    --Runtime:addEventListener("touch", instance.stopShip)
    return instance
end


return ship