local player = require "scripts.playerCreator"
local newBullet = require("scripts.elements.bullet")
local shipSprite = "assets/ship/ship.png"
local newExplosion = require("scripts.elements.explosion")
local scoreManger =  require("scripts.scoreManager")
-- Físicas
local physics = require("physics")
physics.start()
physics.setGravity(0,0)
local ship = {}
--
function ship.new(mainGroup,controller)
    local group = mainGroup
    local instance = display.newImageRect(mainGroup,shipSprite,70,96)
    local eventPhase
    if controller == "keyboard" then
        eventPhase = "up"
    elseif controller == "gamepadtouch" then
        eventPhase = "ended"
    end
    -- Atributos

    instance.shipMoveX = 0
    instance.speed = 6
    instance.x = display.contentCenterX
    instance.y = (display.contentCenterY) * 1.60
    instance.rotation = - 90
    instance.myName = "ship" 
    physics.addBody(instance, "static", {radius=5, isSensor=true});
    -- Métodos

    function instance.bullet()
        if instance.alpha ~= 0 then
            newBullet.new(group,instance.x,instance.y)
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
        if event.phase == eventPhase then
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
            if event.target.myName == "ship" and event.other.myName == "spaceObject" then
                player.subScore(event.other.reward)
                player.setFinalScore()
                print("score final definido: " .. player.getFinalScore())
                scoreManger.add(player.getFinalScore())
                scoreManger.saveScores()
                player.eraseScore()
                instance.destroyShip()
                local explosion = newExplosion.new(
                    768,
                    512,
                    instance.x,
                    instance.y
                )
                local shipDestroyed = audio.loadSound("assets/audio/shipDestroyed.wav")
                audio.play(shipDestroyed)
                timer.performWithDelay(180, explosion.removeExplosion,1)
            end
        end
    end

    instance.collision = instance.onCollision
    instance:addEventListener( "collision", instance )
    return instance
end


return ship