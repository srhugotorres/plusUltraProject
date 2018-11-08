local newExplosion = require("scripts.elements.explosion")
local player = require "scripts.playerCreator"
local physics = require("physics")
physics.start()
physics.setGravity(0,0)

local explosionCounter = 0
local smallAsteroidSprite = "assets/spaceObjects/smallAsteroid/c40007.png"
local mediumAsteroidSprite = "assets/spaceObjects/mediumAsteroid/c40000.png"
local largeAsteroidSprite = "assets/spaceObjects/largeAsteroid/c10015.png"
local IndestructibleAsteroidSprite = "assets/spaceObjects/indestructibleAsteroid/c10006.png"
--
local spaceJunkImages = {}
    spaceJunkImages[1] = "assets/spaceObjects/spaceJunk/RD3.png"
    spaceJunkImages[2] = "assets/spaceObjects/spaceJunk/F5S1.png"
--
local i = math.random(#spaceJunkImages)
local spaceJunkSprite = spaceJunkImages[i]

--
local spaceObject ={}

function spaceObject.new(
    mainGroup,
    objectsTable,
    type,
    resistance,
    reward,
    sprite,
    radius,
    sizeX,
    sizeY,
    myName
)
    local instance = display.newImageRect(mainGroup,sprite,sizeX,sizeY)
    instance.type = type
    instance.resistance = resistance
    instance.reward = reward
    instance.myName = myName
    physics.addBody(instance,"dynamic",{radius,bounce = 0.8})
    table.insert(objectsTable,instance)
    local whereFrom = math.random(2)

    if whereFrom == 1 then
        instance.x = math.random(display.contentCenterX,display.contentCenterX + 800)
        instance.y = display.contentCenterY  - 300
        instance:setLinearVelocity(0, 88)
    elseif whereFrom == 2 then
        instance.x = math.random(display.contentCenterX)
        instance.y = display.contentCenterY  - 300
        instance:setLinearVelocity(0, 88)
    end
    instance:applyTorque( math.random( -6,6 ) )

    function instance.onCollision(self,event)
        if event.phase == "began" then
            if event.target.myName == "spaceObject" and event.other.myName == "bullet" then
                if instance.resistance ~= 0 then
                    instance.resistance = instance.resistance - event.other.efficiency
                else
                    player.addScore(instance.reward)
                    local asteroidDestroyed = audio.loadSound("assets/audio/asteroidDestroyed.wav")
                    audio.play(asteroidDestroyed)
                    local explosion = newExplosion.new(
                        768,
                        512,
                        instance.x,
                        instance.y
                    )
                    timer.performWithDelay(180, explosion.removeExplosion,1)

                    display.remove(event.target)
                    for i = #objectsTable, 1, -1 do
                        if objectsTable[i] == event.target then
                            table.remove( objectsTable, i )
                            break
                        end
                    end
                end
            end
        end
    end
    instance.collision = instance.onCollision
    instance:addEventListener( "collision", instance )
    return instance
end

function spaceObject.createSmallAsteroid(mainGroup,objectsTable)
    local asteroidSprite = smallAsteroidSprite
    local type = "smallAsteroid"
    local radius = 0.5
    local size = 100
    local resistance = 2
    local reward = 10
    local myName = "spaceObject"
    local instance = spaceObject.new(
        mainGroup,
        objectsTable,
        type,
        resistance,
        reward,
        asteroidSprite,
        radius,
        size,
        size,
        myName
    )
    return instance
end
function spaceObject.createMediumAsteroid(mainGroup,objectsTable)
    local asteroidSprite = mediumAsteroidSprite
    local type = "mediumAsteroid"
    local radius = 1
    local size = 150
    local resistance = 4
    local reward = 100
    local myName = "spaceObject"
    local instance = spaceObject.new(
        mainGroup,
        objectsTable,
        type,
        resistance,
        reward,
        asteroidSprite,
        radius,
        size,
        size,
        myName

    )

    return instance
end
function spaceObject.createLargeAsteroid(mainGroup,objectsTable)
    local asteroidSprite = largeAsteroidSprite
    local type = "largeAsteroid"
    local radius = 2
    local size = 180
    local resistance = 6
    local reward = 1000
    local myName = "spaceObject"
    local instance = spaceObject.new(
        mainGroup,
        objectsTable,
        type,
        resistance,
        reward,
        asteroidSprite,
        radius,
        size,
        size,
        myName
    )
    return instance
end
function spaceObject.createIndestructibleAsteroid(mainGroup,objectsTable)
    local asteroidSprite = IndestructibleAsteroidSprite
    local type = "IndestructibleAsteroid"
    local radius = 2
    local size = 200
    local resistance = 1000000000000000000000000000000
    local reward = resistance
    local myName = "spaceObject"
    local instance = spaceObject.new(
        mainGroup,
        objectsTable,
        type,
        resistance,
        reward,
        asteroidSprite,
        radius,
        size,
        size,
        myName
    )
    return instance
end
function spaceObject.createSpaceJunk(mainGroup,objectsTable)
    local asteroidSprite = spaceJunkSprite
    local type = "spaceJunk"
    local radius = 2
    local size = 80
    local resistance = 6
    local reward = 0
    local myName = "spaceObject"
    local instance = spaceObject.new(
        mainGroup,
        objectsTable,
        type,
        resistance,
        reward,
        asteroidSprite,
        radius,
        size,
        size,
        myName
    )
    return instance
end
function spaceObject.createObjects(mainGroup,objectsTable)
    local choose = math.random(16)

    if choose == 1 or choose == 2 or choose == 3 or choose == 4 then
        return spaceObject.createSmallAsteroid(mainGroup,objectsTable)
    elseif choose == 5 or choose == 6 or choose == 7 then
        return spaceObject.createMediumAsteroid(mainGroup,objectsTable)
    elseif choose == 7 or choose == 8  or choose == 9 then
    elseif choose == 10 or choose == 11 or choose == 12 then
        return spaceObject.createSpaceJunk(mainGroup,objectsTable)
    elseif choose == 13 or choose == 14 then
        return spaceObject.createLargeAsteroid(mainGroup,objectsTable)
    elseif choose == 16 then
        return spaceObject.createIndestructibleAsteroid(mainGroup,objectsTable)
    end

end
return spaceObject