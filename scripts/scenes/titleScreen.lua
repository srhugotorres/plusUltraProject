local composer = require( "composer" )
local widget = require( "widget" )

local background, title, playButton, scoresButton, instructionsButton

local scene = composer.newScene()
local titleBackGroundSound, playTitleBG

local function goToGame()
    composer.gotoScene( "scripts.scenes.stage")
end
local function goScores()
    composer.gotoScene( "scripts.scenes.scores" )
end
local function exit()
    os.exit()
end
function scene:create( event )
 
    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen
end
 
 
-- show()
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
        
    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen

        titleBackGroundSound = audio.loadStream("assets/audio/titleScreen.mp3")
        background   = display.newImageRect("assets/screens/titleScreen.png", 1920,1080)
        background.x = display.contentCenterX
        background.y = display.contentCenterY

        title   = display.newImageRect("assets/elements/plusUltraTitle.png", 500, 500)
        title.x = display.contentCenterX
        title.y = display.contentCenterY * 0.4
        
        playButton   = display.newImageRect("assets/elements/playButton.png",200,100)
        playButton.x = display.contentCenterX
        playButton.y = display.contentCenterY

        scoresButton   = display.newImageRect("assets/elements/scoresButton.png",200,100) 
        scoresButton.x = display.contentCenterX
        scoresButton.y = display.contentCenterY * 1.30

        exitButton   = display.newImageRect("assets/elements/exitButton.png",200,100) 
        exitButton.x = display.contentCenterX
        exitButton.y = display.contentCenterY * 1.60
        --[[
        ]]--    
        playTitleBG = audio.play(titleBackGroundSound,{loops = -1})
        playButton:addEventListener( "tap", goToGame )
        scoresButton:addEventListener( "tap", goScores )
        exitButton:addEventListener( "tap", exit )
    end
end
 
 
-- hide()
function scene:hide( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is on screen (but is about to go off screen)
 
    elseif ( phase == "did" ) then
        -- Code here runs immediately after the scene goes entirely off screen
        audio.stop(playTitleBG)
        titleBackGroundSound = nil
        playTitleBG = nil
        display.remove(background)
        display.remove(title)
        display.remove(playButton)
        display.remove(scoresButton)
        display.remove(exitButton)
        display.remove(instructionsButton)
        playButton:removeEventListener( "tap", goToGame )
        scoresButton:removeEventListener( "tap", goScores )
        exitButton:addEventListener( "tap", exit )
    end
end
 
 
-- destroy()
function scene:destroy( event )
 
    local sceneGroup = self.view
    -- Code here runs prior to the removal of scene's view
 
end
 
 
-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------
 
return scene
