local scoreLog = {}
function scoreLog.new(dateTime,score)
    local instance = {}
    instance.dateTime = dateTime
    instance.score = score
    function instance.getScore()
        return tostring(instance.score)
    end
    function instance.getDateTime()
        return instance.dateTime
    end
    return instance
end
return scoreLog