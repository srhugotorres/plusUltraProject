local newPlayer = require "scripts.elements.player"
local playerCreator = {}
local player = newPlayer.new("jogador1")
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
        player.score = player.score - score
        playerCreator.showScore()
    else
        print("sem score")
        playerCreator.showScore()
    end
end
return playerCreator
