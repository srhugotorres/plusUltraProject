local newPlayer = require "scripts.elements.player"
local playerCreator = {}
local player = newPlayer.new("Player Name")
function playerCreator.getPlayer()
    return player
end
function playerCreator.showScore()
    print("score atual: " .. player.score)
end
function playerCreator.getScore()
    return player.score
end
function playerCreator.addScore(score)
    player.score = player.score + score
    playerCreator.showScore()
end
function playerCreator.subScore(score)
    if player.score ~= 0 then
        if (player.score - score < 0) then
            player.score = 0
        else
            player.score = player.score - score
        end
        playerCreator.showScore()
    else
        print("sem score")
        playerCreator.showScore()
    end
end
function playerCreator.getName()
    return player.name
end
function playerCreator.getScore()
    return player.score
end
function playerCreator.setFinalScore()
    player.finalScore = player.score
end
return playerCreator
