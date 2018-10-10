local newAsteroid = require("scripts.elements.spaceObject")
local spaceObjectTable = {}
local objectsGenerator = {}
local mainGroupLocal

function objectsGenerator.generate()
    newAsteroid.createObjects(mainGroupLocal,spaceObjectTable,"contemporary")
    for i = #spaceObjectTable, 1, -1 do
        local thisAsteroid = spaceObjectTable[i]
        if ( thisAsteroid.x < -300 or
        thisAsteroid.x > display.contentWidth + 100 or
        thisAsteroid.y < -300 or
        thisAsteroid.y > display.contentHeight + 100 )
        then
            display.remove( thisAsteroid )
            table.remove( spaceObjectTable, i )
        end
    end
end

function objectsGenerator.run(mainGroup)
    mainGroupLocal = mainGroup
    timer.performWithDelay( 500, objectsGenerator.generate, 0 )
end

function objectsGenerator.getSpaceObjectTable()
    return spaceObjectTable
end

return objectsGenerator