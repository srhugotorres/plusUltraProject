local spaceObjectTable
local shipCollision
local collision = {}

function collision.on(event)

    if  event.phase == "began"  then

        local obj1 = event.object1
        local obj2 = event.object2
    end

    if  event.phase == "began"  then

        local obj1 = event.object1
        local obj2 = event.object2
        if  obj1.myName == "ship" and  obj2.myName == "asteroid"
            or obj1.myName == "asteroid" and  obj2.myName ==  "ship" then
            died = true

            shipCollision.destroyShip()

        elseif obj1.myName == "bullet" and  obj2.myName == "asteroid"
        or obj1.myName == "asteroid" and  obj2.myName ==  "bullet"  then

            display.remove( obj1 )
            display.remove( obj2 )
            for i = #spaceObjectTable, 1, -1 do
                if ( spaceObjectTable[i] == obj1 or spaceObjectTable[i] == obj2 ) then
                    table.remove( spaceObjectTable, i )
                    break
                end
            end

        end
    end
end
function collision.run(table,ship)
    spaceObjectTable = table
    shipCollision = ship
    Runtime:addEventListener( "collision", collision.on )
end

return collision