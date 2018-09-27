local gamepad = {}
function gamepad.new()
    local instance ={}
    instance.arrow = "assets/gamepad/arrow.png"
    instance.shoot = "assets/gamepad/shootButton.png"
    -- leftArrow
    instance.leftArrow = display.newImageRect(instance.arrow,80,80)
    instance.leftArrow.x = (display.screenOriginX * 0.586510264)
    instance.leftArrow.y = display.contentCenterY * 1.8
    instance.leftArrow.rotation = -90
    -- right Arrow
    instance.rightArrow = display.newImage(instance.arrow,80,80)
    instance.rightArrow.x =	-(display.screenOriginX * 0.586510264)
    instance.rightArrow.y = display.contentCenterY * 1.8
    instance.rightArrow.rotation = 90
    -- shootButton
    instance.shootButton = display.newImageRect(instance.shoot,80,80)
    instance.shootButton.x = display.screenOriginX +  1250
    instance.shootButton.y = display.contentCenterY * 1.8
    --[[
    -- arrowTouch
    instance.rightArrowTouch = rightArrowtouch
    instance.leftArrowTouch = leftArrowtouch
    ]]--
    --
    instance.stopShip = stopShip
    instance.moveShip = moveShip
    --
    --instance.leftArrow:addEventListener ("touch", instance.leftArrowTouch)
    --instance.rightArrow:addEventListener ("touch", instance.rightArrowTouch)
   
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

return gamepad