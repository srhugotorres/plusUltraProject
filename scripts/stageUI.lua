local player = require "scripts.playerCreator"

local stageUI = {}
function stageUI.run(uiGroup)
    local playerName = display.newText(uiGroup,player.getName(), display.screenOriginX + 120, display.screenOriginY + 30, native.systemFont, 60)
    local score      = display.newText(uiGroup,player.getScore(), display.screenOriginX + 1300, display.screenOriginY + 30, native.systemFont, 60)
    timer.performWithDelay( 1, function() score.text = player.getScore() end, -1 )
end

return stageUI