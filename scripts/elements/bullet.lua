--
local bulletSprite = "assets/ship/fireball.png"
--
local physics = require("physics")
physics.start()
physics.setGravity(0,0)
--
local bullet = {}
function bullet.new(mainGroup,shipX,shipY)
    local instance = display.newImageRect(mainGroup,bulletSprite,30,30)
    instance.rotation = 90
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

    function instance.onCollision(self,event)
        if event.phase == "began" then
            if event.target.myName == "bullet" and event.other.myName == "spaceObject" then
                display.remove(event.target)
                
            end
        end
    end
    instance.collision = instance.onCollision
    instance:addEventListener( "collision", instance )

    return instance
end
return bullet