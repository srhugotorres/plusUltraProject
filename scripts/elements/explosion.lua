local explosionSprite = "assets/spaceObjects/explosion/explosion.png"
local explosion = {}
function explosion.new(sizeX,sizeY,positionX,positionY)
    local instance = {}
    instance.explosionSheetData = {
        width = 250,
        height= 120,
        numFrames = 12,
        sheetContentWidth = sizeX,
        sheetContentHeight = sizeY
    }
    instance.explosionSheet = graphics.newImageSheet(
        explosionSprite,
        instance.explosionSheetData
    )
    instance.explosionSequenceData = {
        {name="explosion", start = 1, count = 5, time = 200, loopCount = 1}
    }
    instance.explosion = display.newSprite(
        instance.explosionSheet,
        instance.explosionSequenceData
    )
    instance.explosion.x = positionX
    instance.explosion.y = positionY
    instance.explosion:play()
    function instance.removeExplosion()
        display.remove(instance.explosion)
        instance.explosionSheetData = nil
        instance.explosionSequenceData = nil
        instance.explosion = nil
    end
    return instance
end

return explosion