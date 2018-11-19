local player = require "scripts.playerCreator"

local stageUI = {}
function stageUI.run(uiGroup)

    --local playerName = display.newText(uiGroup,player.getName(), display.contentWidth * 0.07  , display.contentHeight * 0.05, native.systemFont, 25)
    local score      = display.newText(uiGroup,player.getScore(), display.contentCenterX,  display.contentHeight * 0.08, native.systemFont, 60)

    timer.performWithDelay( 1, function() score.text = player.getScore() end, -1 )
end

return stageUI