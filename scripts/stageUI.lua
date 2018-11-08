local player = require "scripts.playerCreator"

local stageUI = {}
function stageUI.run(uiGroup)

    local playerName = display.newText(uiGroup,player.getName(), display.contentWidth * 0.07  , display.contentHeight * 0.05, native.systemFont, 25)
    local score      = display.newText(uiGroup,player.getScore(), display.contentWidth * 0.973,  display.contentHeight * 0.05, native.systemFont, 25)

    timer.performWithDelay( 1, function() score.text = player.getScore() end, -1 )
end

return stageUI