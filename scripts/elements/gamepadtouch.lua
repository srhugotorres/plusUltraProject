local gamepadtouch = {}
function gamepadtouch.new()
    local instance ={}
    instance.arrow = "assets/gamepadtouch/arrow.png"
    instance.shoot = "assets/gamepadtouch/shootButton.png"
    -- leftArrow
    instance.leftArrow = display.newImageRect(instance.arrow,80,80)
    instance.leftArrow.x = display.contentWidth * 0.04
    instance.leftArrow.y = display.contentCenterY * 1.8
    instance.leftArrow.rotation = -90
    -- right Arrow
    instance.rightArrow = display.newImage(instance.arrow,80,80)
    instance.rightArrow.x =	display.contentWidth * 0.2
    instance.rightArrow.y = display.contentCenterY * 1.8
    instance.rightArrow.rotation = 90
    -- shootButton
    instance.shootButton = display.newImageRect(instance.shoot,80,80)
    instance.shootButton.x = display.contentWidth * 0.971
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