local player = {}
function player.new(name)
    local instance = {}
    instance.name = name
    instance.score = 0
    return instance
end
return player
