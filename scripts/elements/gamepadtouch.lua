local stage = display.getCurrentStage()
local gamepadtouch = {}
function gamepadtouch.new()
    local instance ={}
    instance.arrow = "assets/gamepadtouch/arrow.png"
    instance.shoot = "assets/gamepadtouch/shootButton.png"
    local size = 130
    -- leftArrow
    instance.leftArrow = display.newImageRect(instance.arrow,size,size)
    instance.leftArrow.x = display.contentWidth * 0.06
    instance.leftArrow.y = display.contentCenterY * 1.8
    instance.leftArrow.rotation = -90
    -- right Arrow
    instance.rightArrow = display.newImageRect(instance.arrow,size,size)
    instance.rightArrow.x =	display.contentWidth * 0.2
    instance.rightArrow.y = display.contentCenterY * 1.8
    instance.rightArrow.rotation = 90
    -- shootButton
    instance.shootButton = display.newImageRect(instance.shoot,size,size)
    instance.shootButton.x = display.contentWidth * 0.954
    instance.shootButton.y = display.contentCenterY * 1.8
    --
    instance.stopShip = stopShip
    instance.moveShip = moveShip
    
    function instance.getLeftArrow()
        return instance.leftArrow
    end
    function instance.getRightArrow()
        return instance.rightArrow
    end
    function instance.getShootButton()
        return instance.shootButton
    end
    return instance
end

return gamepadtouch