local bullet = {}
function bullet.new(mainGroup,shipX,shipY)
    local instance = {}
    instance.bulletStyle = "assets/style/Contemporary/ship/fireball.png"
    instance.bullet = display.newImageRect(mainGroup,instance.bulletStyle,30,30)
    physics.addBody(instance.bullet,"dynamic",{isSensor=true})
    instance.bullet.isBullet = true
    instance.bullet.myName = "bullet"
    instance.bullet.x = shipX
    instance.bullet.y = shipY
    instance.bullet:toBack()
    transition.to(
        instance.bullet,
        {
            y = -40,
            time = 500,
            onComplete = function()
            display.remove(instance.bullet)
            end
        }
    )
    function instance.getBullet()
        return instance.bullet
    end
    function instance.getMyName()
        return instance.bullet.myName
    end
    return instance
end
return bullet