local centerWidth = display.contentCenterX
local centerHeight = display.contentCenterY
local backgroundStyle = {}
    backgroundStyle["contemporary"] = "assets/style/contemporary/background/spacebackground.png"
local background = {}
function background.new(backGroup,style,sizeX,sizeY)
    local instance = {}
    instance.backgroundStyle = backgroundStyle[style]
    instance.background = display.newImageRect(backGroup,instance.backgroundStyle,sizeY,sizeX )
    instance.background.rotation = 90
    instance.background.speed = 0.5
    instance.background.x = centerWidth
    instance.background.y = centerHeight
    function instance.scroll(self,event)
        if self.y > 800 then
            self.y = 0.1
        else
            self.y = self.y + self.speed
        end
    end
    instance.background.enterFrame = instance.scroll
    Runtime:addEventListener("enterFrame",instance.background)
    return instance
end
return background