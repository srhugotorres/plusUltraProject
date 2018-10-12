local newGamepad = require("scripts.elements.gamepad")
local newBullet = require("scripts.elements.bullet")
local shipStyle = {}
shipStyle["contemporary"] = "assets/style/Contemporary/ship/ship.png"
shipStyle["retro"] ="assets/style/Retro/ship/2.png"
-- Físicas
local physics = require("physics")
physics.start()
physics.setGravity(0,0)
local shootName = "bullet"
local ship = {}

function ship.new(mainGroup,style)
    local group = mainGroup
    local styleShip = shipStyle[style]
    local instance = display.newImageRect(mainGroup,styleShip,70,96)
    -- Atributos

    instance.shipMoveX = 0
    instance.speed = 6
    instance.x = display.contentCenterX
    instance.y = (display.contentCenterY) * 1.65 
    instance.rotation = - 90
    instance.myName = "ship"

    physics.addBody(instance, "static", {radius=50, isSensor=true});

    -- Métodos
    function instance.setMyName(name)
        instance.myName = name
    end
    function instance.bullet()
        if instance.alpha ~= 0 then
            newBullet.new(group,style,instance.x,instance.y)
        end
    end
    function instance.getShip()
        return instance
    end
    function instance.getMoveX()
        return instance.shipMoveX
    end
    function instance.setMoveX(moveX)
        instance.shipMoveX = moveX
    end
    function instance.createEdges(event)
        if instance.x < 0 then
            instance.x = 0
        end
        if instance.x > display.contentWidth - 1 then
            instance.x = display.contentWidth - 1
        end
    end

    function instance.stopShip(event)
        if event.phase == "ended" then
            instance.shipMoveX = 0
        end
    end
    function instance.moveShip(event)
        instance.x = instance.x + instance.shipMoveX
    end

    function instance.moveLeft()
        instance.shipMoveX = - instance.speed
    end
    function instance.moveRight()
        instance.shipMoveX =  instance.speed
    end
    function instance.destroyShip()
        instance.alpha = 0
        instance.myName = nil
    end
    function instance.onCollision(self,event)
        if event.phase == "began" then
            if event.target.myName == "ship" and event.other.myName == "asteroid" then
                instance.destroyShip()
            end
        end
    end

    instance.collision = instance.onCollision
    instance:addEventListener( "collision", instance )
    return instance
end


return ship