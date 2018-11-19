local newPlayer = require "scripts.elements.player"
local playerCreator = {}
local player = newPlayer.new("Player Name")
function playerCreator.getPlayer()
    return player
end
function playerCreator.getScore()
    return player.score
end
function playerCreator.addScore(score)
    player.score = player.score + score
end
function playerCreator.subScore(score)
    if player.score ~= 0 then
        if (player.score - score < 0) then
            player.score = 0
        else
            player.score = player.score - score
        end
    end
end
function playerCreator.getScore()
    return player.score
end
function playerCreator.setFinalScore()
    player.finalScore = player.score
end
function playerCreator.eraseScore()
    player.score = 0
end
function playerCreator.getFinalScore()
    return player.finalScore
end
return playerCreator
