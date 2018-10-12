local physics = require("physics")
physics.start()
physics.setGravity(0,0)
local smallAsteroidStyle = {}
    smallAsteroidStyle["contemporary"] = "assets/style/Contemporary/asteroids/small/c40007.png"
local mediumAsteroidStyle = {}
    mediumAsteroidStyle["contemporary"] = "assets/style/Contemporary/asteroids/medium/c40000.png"
local largeAsteroidStyle = {}
    largeAsteroidStyle["contemporary"] = "assets/style/Contemporary/asteroids/large/c10015.png"

local spaceObject ={}

function spaceObject.new(
    mainGroup,
    objectsTable,
    type,
    resistance,
    reward,
    style,
    sizeX,
    sizeY,
    myName
)
    local instance = display.newImageRect(mainGroup,style,sizeX,sizeY)
    instance.type = type
    instance.resistance = resistance
    instance.reward = reward
    instance.myName = myName
    physics.addBody(instance,"dynamic",{radius = 48,bounce = 0.8})
    table.insert(objectsTable,instance)
    local whereFrom = math.random(2)

    if whereFrom == 1 then
        instance.x = math.random(display.contentCenterX + 10,display.contentCenterX + 800)
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
            if event.target.myName == "asteroid" and event.other.myName == "bullet" then
                if instance.resistance ~= 0 then
                    instance.resistance = instance.resistance - event.other.efficiency
                else
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

function spaceObject.createSmallAsteroid(mainGroup,objectsTable,style)
    local asteroidStyle = smallAsteroidStyle[style]
    local type = "smallAsteroid"
    local size = 100
    local resistance = 2
    local reward = 10
    local myName = "asteroid"
    local instance = spaceObject.new(
        mainGroup,
        objectsTable,
        type,
        resistance,
        reward,
        asteroidStyle,
        size,
        size,
        myName
    )
    return instance
end
function spaceObject.createMediumAsteroid(mainGroup,objectsTable,style)
    local asteroidStyle = mediumAsteroidStyle[style]
    local type = "mediumAsteroid"
    local size = 150
    local resistance = 4
    local reward = 100
    local myName = "asteroid"
    local instance = spaceObject.new(
        mainGroup,
        objectsTable,
        type,
        resistance,
        reward,
        asteroidStyle,
        size,
        size,
        myName

    )

    return instance
end
function spaceObject.createLargeAsteroid(mainGroup,objectsTable,style)
    local asteroidStyle = largeAsteroidStyle[style]
    local type = "largeAsteroid"
    local size = 180
    local resistance = 6
    local reward = 1000
    local myName = "asteroid"
    local instance = spaceObject.new(
        mainGroup,
        objectsTable,
        type,
        resistance,
        reward,
        asteroidStyle,
        size,
        size,
        myName
    )
    return instance
end

function spaceObject.createObjects(mainGroup,objectsTable,style)
    local choose = math.random(6)

    if choose == 1 or choose == 2 or choose == 3 then
        return spaceObject.createSmallAsteroid(mainGroup,objectsTable,style)
    elseif choose == 4 or choose == 5 then
        return spaceObject.createMediumAsteroid(mainGroup,objectsTable,style)
    elseif choose == 6 then
        return spaceObject.createLargeAsteroid(mainGroup,objectsTable,style)
    end

end
return spaceObject