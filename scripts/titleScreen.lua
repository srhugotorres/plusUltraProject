local composer = require( "composer" )
 
local scene = composer.newScene()
local titleBackGroundSound = audio.loadStream("assets/audio/titleScreen.mp3")
local playTitleBG = audio.play(titleBackGroundSound)
local function goToGame()
    audio.stop(playTitleBG)
    titleBackGroundSound = nil
    playTitleBG = nil
    composer.gotoScene( "scripts.stage" )
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
        local background = display.newImageRect("assets/screens/titleScreen.png", 1920,1080)
            background.x = display.contentCenterX
            background.y = display.contentCenterY
        local title = display.newText("Plus Ultra",display.contentCenterX,display.contentCenterY - 200,native.systemFont, 100 )
            title:setFillColor( 0.82, 0.86, 1 ) 
        local playButton = display.newText("Play", display.contentCenterX,display.contentCenterY,native.systemFont, 66)
            playButton:setFillColor( 0.82, 0.86, 1 )
            playButton:addEventListener( "tap", goToGame )
    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
 
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
