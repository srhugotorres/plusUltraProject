local player = require("scripts.playerCreator")
local newScore = require("scripts.elements.scoreLog")
local dateTime = os.date("%d") .. "/" .. os.date("%m") .. " - " .. os.date("%H") .. ":" .. os.date("%M") .. ":" .. os.date("%S")

local json = require( "json" )

local scoresTable = {}
local filePath = system.pathForFile( "scores.json", system.DocumentsDirectory )
local scoreManager = {}

function scoreManager.add(finalScore)
    print("finalScore: " .. finalScore) 
    local scoreLog = newScore.new(
        dateTime,
        finalScore
    )
    if scoresTable[1].score == 0 then
        scoresTable[1] = nil
        scoresTable[1] = scoreLog
    else
        scoreManager.compare(scoreLog)
    end
    
end
function scoreManager.compare(scoreLog)
    for i=1 , 5 do
        if scoreLog.score > scoresTable[i].score then
            local tmp = scoresTable[i]
            scoresTable[i] = nil
            scoresTable[i] = scoreLog
            scoreManager.compare(tmp)
            break
        elseif scoreLog.score < scoresTable[i].score then
            i = i + 1
        else
            scoresTable[i] = nil
            scoresTable[i] = scoreLog
            break
        end
    end
end
function scoreManager.loadScores()

	local file = io.open( filePath, "r" )
    
	if file then
		local contents = file:read( "*a" )
		io.close( file )
		scoresTable = json.decode( contents )
	end
    
	if ( scoresTable == nil or #scoresTable == 0 ) then
        local firstDateTime = "00/00 - 00:00:00" 
        local scoreInicial = 0
        scoresTable = { 
            newScore.new(
            firstDateTime,
            scoreInicial
        ), 
            newScore.new(
            firstDateTime,
            scoreInicial
        ), 
            newScore.new(
            firstDateTime,
            scoreInicial
        ), 
            newScore.new(
            firstDateTime,
            scoreInicial
        ), 
            newScore.new(
            firstDateTime,
            scoreInicial
        ) 
        }
	end
end


function scoreManager.saveScores()

	for i = #scoresTable, 6, -1 do
		table.remove( scoresTable, i )
	end

	local file = io.open( filePath, "w" )

	if file then
		file:write( json.encode( scoresTable ) )
		io.close( file )
	end
end
function scoreManager.print(scoreGroup)
    if  scoresTable[1].score == 0 then
        for i = 1, 5 do
            if ( scoresTable[i] ) then
                local positionX = display.contentCenterX * 0.8
                local positionY = 130 + ( i * 80 )
                                
                local rankNum = display.newText( 
                    scoreGroup,
                    i .. ") " .. scoresTable[i].dateTime .. " -   ", 
                    positionX, 
                    positionY, 
                    native.systemFont, 
                    50 
                )
                rankNum:setFillColor( 1 )
                rankNum.anchorX = 1
                
                local thisScore = display.newText( 
                    scoreGroup,
                    scoresTable[i].score, 
                    positionX, 
                    positionY, 
                    native.systemFont, 
                    50 
                 )
                thisScore.anchorX = 0
                thisScore:setFillColor( 1 )
                i = i + 1
            end
        end
    else    
    
        for i = 1, 5 do
            local positionX = display.contentCenterX * 0.8
            local positionY = 130 + ( i * 80 )
            local rankNum = display.newText( 
                scoreGroup,
                i.. ") ".. scoresTable[i].dateTime .. " -   ", 
                positionX, 
                positionY, 
                native.systemFont, 
                50 
            )
                rankNum:setFillColor( 1 )
                rankNum.anchorX = 1
        
            local thisScore = display.newText(
                scoreGroup,
                scoresTable[i].score, 
                positionX, 
                positionY, 
                native.systemFont, 
                50 
            )
                thisScore.anchorX = 0
                thisScore:setFillColor( 1 )
            end
    end
end
return scoreManager