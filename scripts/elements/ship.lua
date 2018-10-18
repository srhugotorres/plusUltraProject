local player = require "scripts.playerCreator"
local newGamepad = require("scripts.elements.gamepadtouch")
local newBullet = require("scripts.elements.bullet")
local shipStyle = {}
shipStyle["contemporary"] = "assets/style/contemporary/ship/ship.png"

-- Físicas
local physics = require("physics")
physics.start()
physics.setGravity(0,0)
local shootName = "bullet"
local ship = {}
--
--
local explosionSheetData = {
    width =250,
    height= 120,
    numFrames = 12,
    sheetContentWidth = 768,
    sheetContentHeight = 512
}
local explosionSheet = graphics.newImageSheet("assets/style/contemporary/spaceObjects/explosion/explosion.png", explosionSheetData)
local explosionSequenceData = {
    {name="explosion", start = 1, count = 5, time = 200, loopCount = 1}
}
local explosion = {}
local explosionCounter = 0
--
function ship.new(mainGroup,style,controller)
    local group = mainGroup
    local styleShip = shipStyle[style]
    local instance = display.newImageRect(mainGroup,styleShip,70,96)
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
    physics.addBody(instance, "static", {radius=20, isSensor=true});
    -- Métodos

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
                instance.destroyShip()
                explosion = display.newSprite(explosionSheet,explosionSequenceData)
                    explosion.x = instance.x
                    explosion.y = instance.y
                explosion:play()
                local function removeExplosion()
                    if explosion ~= nil then
                        display.remove(explosion)
                    end
                end
                local shipDestroyed = audio.loadSound("assets/audio/shipDestroyed.wav")
                audio.play(shipDestroyed)
                timer.performWithDelay(255, removeExplosion,1)
            end
        end
    end

    instance.collision = instance.onCollision
    instance:addEventListener( "collision", instance )
    return instance
end


return ship