local keyboard = {}
local shipLocal
function keyboard.new(ship)
    shipLocal = ship
end
function keyboard.run(event)
    if event.keyName == "left" then
        shipLocal.moveLeft()
        return true
    elseif event.keyName == "right" then
        shipLocal.moveRight()
        return true
    elseif event.keyName == "z" then
        shipLocal.bullet()
        return true
    end
end

return keyboard