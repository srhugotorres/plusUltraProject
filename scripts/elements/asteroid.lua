local physics = require("physics")
physics.start()
physics.setGravity(0,0)
local _LeftPosition = display.contentCenterX - 610
local _RightPosition = display.contentCenterX + 610
local _CenterPosition = display.contentCenterX
local _CenterLeftArea = (_LeftPosition + _CenterPosition)/2
local _CenterRightArea = (_RightPosition + _CenterPosition)/2
local _AsteroidHightPosition = display.contentCenterY  - 300
local asteroid = {}
function asteroid.new(mainGroup,asteroidsTable)
    local instance = {}
    instance.asteroidStyle = "assets/style/Contemporary/asteroids/medium/c40000.png"
    instance.asteroid = display.newImageRect(mainGroup,instance.asteroidStyle,150,150)
    table.insert(asteroidsTable,instance.asteroid)

    instance.asteroid.myName = "asteroid"
    physics.addBody(instance.asteroid,"dynamic",{radius = 48, bounce=0.8})

    local whereFrom = math.random(2)
    print(whereFrom)
    if ( whereFrom == 1 ) then
        instance.asteroid.x = math.random(display.contentCenterX + 10,display.contentCenterX + 800)
        instance.asteroid.y = display.contentCenterY  - 300
        instance.asteroid:setLinearVelocity(0, 88)
    elseif ( whereFrom == 2 ) then
        instance.asteroid.x = math.random(display.contentCenterX)
        instance.asteroid.y = display.contentCenterY  - 300
        instance.asteroid:setLinearVelocity(0, 88)
    end
    --[[
    if whereFrom == 1 then
        instance.asteroid.x = _CenterPosition
        instance.asteroid.y = _AsteroidHightPosition
        instance.asteroid:setLinearVelocity(0, 88)
    elseif whereFrom == 2 then
        instance.asteroid.x = math.random( _CenterLeftArea,_CenterPosition )
        instance.asteroid.y = _AsteroidHightPosition
        instance.asteroid:setLinearVelocity(0, 88)
    elseif whereFrom == 3 then
        instance.asteroid.x = _RightPosition
        instance.asteroid.y = _AsteroidHightPosition
        instance.asteroid:setLinearVelocity(0, 88)
    elseif whereFrom == 4 then
        instance.asteroid.x = math.random(_CenterRightArea,_RightPosition)
        instance.asteroid.y = _AsteroidHightPosition
        instance.asteroid:setLinearVelocity(0, 88)
    elseif whereFrom == 5 then
        instance.asteroid.x = _LeftPosition
        instance.asteroid.y = _AsteroidHightPosition
        instance.asteroid:setLinearVelocity(0, 88)
    elseif whereFrom == 6 then
        instance.asteroid.x = math.random(_CenterPosition , _CenterRightArea)
        instance.asteroid.y = _AsteroidHightPosition
        instance.asteroid:setLinearVelocity(0, 88)
    elseif whereFrom == 7 then
        instance.asteroid.x = _CenterLeftArea
        instance.asteroid.y = _AsteroidHightPosition
        instance.asteroid:setLinearVelocity(0, 88)
    elseif whereFrom == 8 then
        instance.asteroid.x = _CenterRightArea
        instance.asteroid.y = _AsteroidHightPosition
        instance.asteroid:setLinearVelocity(0, 88)
    elseif whereFrom == 9 then
        instance.asteroid.x = math.random(_LeftPosition,_CenterLeftArea)
        instance.asteroid.y = _AsteroidHightPosition
        instance.asteroid:setLinearVelocity(0, 88)
    
    end
    ]]--
    instance.asteroid:applyTorque( math.random( -6,6 ) )

end
return asteroid 