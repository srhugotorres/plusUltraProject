--
local bulletStyle = {}
    bulletStyle["contemporary"] = "assets/style/Contemporary/ship/fireball.png"
--
local physics = require("physics")
physics.start()
physics.setGravity(0,0)
--
local bullet = {}
function bullet.new(mainGroup,style,shipX,shipY)
    local bulletStyle = bulletStyle[style]
    local instance = display.newImageRect(mainGroup,bulletStyle,30,30)
    instance.efficiency = 1
    physics.addBody(instance,"dynamic",{isSensor=true})
    instance.isBullet = true
    instance.myName = "bullet"
    instance.x = shipX
    instance.y = shipY
    instance:toBack()
    transition.to(
        instance,
        {
            y = -40,
            time = 500,
            onComplete = function()
            display.remove(instance)
            end
        }
    )
    local shootSound = audio.loadSound("assets/audio/shoot.wav")
    audio.play(shootSound)
--[[
    function instance.destroy()
        print("bala acertou asteroide")
    end
]]--
    function instance.onCollision(self,event)
        if event.phase == "began" then
            if event.target.myName == "bullet" and event.other.myName == "asteroid" then
                --instance.destroy()
                display.remove(event.target)
            end
        end
    end
    instance.collision = instance.onCollision
    instance:addEventListener( "collision", instance )

    return instance
end
return bullet