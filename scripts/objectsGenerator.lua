local newAsteroid = require("scripts.elements.spaceObject")
local spaceObjectTable = {}
local objectsGenerator = {}
local mainGroupLocal

function objectsGenerator.generate()
    newAsteroid.createObjects(mainGroupLocal,spaceObjectTable)
    for i = #spaceObjectTable, 1, -1 do

        local thisObject = spaceObjectTable[i]
        if thisObject.x ~= nil and thisObject.y ~= nil then
            if ( thisObject.x < -300 or
            thisObject.x > display.contentWidth + 100 or
            thisObject.y < -300 or
            thisObject.y > display.contentHeight + 100 )
            then
                display.remove(thisObject.object)
                thisObject.myName = nil

                table.remove( spaceObjectTable, i )
            end
        else
            -- Cancela a trajetória do asteroide
            -- Significa que o asteroide foi destruido
            display.remove(thisObject)
            thisObject.myName = nil
            table.remove(spaceObjectTable,i)
        end
    end
end

function objectsGenerator.run(mainGroup)
    mainGroupLocal = mainGroup
    timer.performWithDelay( 500, objectsGenerator.generate, 0 )
end

function objectsGenerator.getTable()
    return spaceObjectTable
end

return objectsGenerator