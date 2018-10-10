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
    local instance = {}
    -- Atributos
    instance.group = mainGroup
    instance.style = shipStyle[style]
    
    instance.shipMoveX = 0
    instance.speed = 6
    instance.ship = display.newImageRect(mainGroup,instance.style,70,96)
        instance.ship.x = display.contentCenterX
        instance.ship.y = (display.contentCenterY) * 1.65 
        instance.ship.rotation = - 90
        instance.ship.myName = "ship"
    physics.addBody(instance.ship, "static", {radius=50, isSensor=true});

    -- Métodos
    function instance.setMyName(name)
        instance.ship.myName = name
    end
    function instance.bullet()
        if instance.ship.alpha ~= 0 then
            newBullet.new(instance.group,style,instance.ship.x,instance.ship.y)
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

    function instance.stopShip(event)
        if event.phase == "ended" then
            instance.shipMoveX = 0
        end
    end
    function instance.moveShip(event)
        instance.ship.x = instance.ship.x + instance.shipMoveX
    end

    function instance.moveLeft()
        instance.shipMoveX = - instance.speed
    end
    function instance.moveRight()
        instance.shipMoveX =  instance.speed
    end
    function instance.destroyShip()
        instance.ship.alpha = 0
        instance.ship.myName = nil
    end
    return instance
end


return ship