local physics = require("physics")
physics.start()
physics.setGravity(0,0)
local spaceObject ={}
function spaceObject.new(
    mainGroup,
    objectsTable,
    style,
    sizeX,
    sizeY,
    myName
)
    local instance = {}
    instance.object = display.newImageRect(mainGroup,style,sizeX,sizeY)
    table.insert(objectsTable,instance.object)
    instance.object.myName = myName
    physics.addBody(instance.object,"dynamic",{radius = 48,bounce = 0.8})

    local whereFrom = math.random(2)

    if whereFrom == 1 then
        instance.object.x = math.random(display.contentCenterX + 10,display.contentCenterX + 800)
        instance.object.y = display.contentCenterY  - 300
        instance.object:setLinearVelocity(0, 88)
    elseif whereFrom == 2 then
        instance.object.x = math.random(display.contentCenterX)
        instance.object.y = display.contentCenterY  - 300
        instance.object:setLinearVelocity(0, 88)
    end
    instance.object:applyTorque( math.random( -6,6 ) )

    return instance
end

function spaceObject.createSmallAsteroid(mainGroup,objectsTable)
    local style = "assets/style/Contemporary/asteroids/small/c40007.png"
    local size = 100
    local myName = "asteroid"
    local instance = spaceObject.new(
        mainGroup,
        objectsTable,
        style,
        size,
        size,
        myName
    )
    return instance
end
function spaceObject.createMediumAsteroid(mainGroup,objectsTable)
    local style = "assets/style/Contemporary/asteroids/medium/c40000.png"
    local size = 180
    local myName = "asteroid"
    local instance = spaceObject.new(
        mainGroup,
        objectsTable,
        style,
        size,
        size,
        myName

    )

    return instance
end
function spaceObject.createLargeAsteroid(mainGroup,objectsTable)
    local style = "assets/style/Contemporary/asteroids/large/c10015.png"
    local size = 250
    local myName = "asteroid"
    local instance = spaceObject.new(
        mainGroup,
        objectsTable,
        style,
        size,
        size,
        myName
    )
    return instance
end

function spaceObject.createObjects(mainGroup,objectsTable)
    local choose = math.random(6)

    if choose == 1 or choose == 2 or choose == 3 then
        return spaceObject.createSmallAsteroid(mainGroup,objectsTable)
    elseif choose == 4 or choose == 5 then
        return spaceObject.createMediumAsteroid(mainGroup,objectsTable)
    elseif choose == 6 then
        return spaceObject.createLargeAsteroid(mainGroup,objectsTable)
    end

end
return spaceObject