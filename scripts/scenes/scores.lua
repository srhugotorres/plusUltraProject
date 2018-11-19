local composer = require( "composer" )
local scene = composer.newScene()
 
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
local backGroup,mainGroup 

local title,background,exitButton,titleBackGroundSound, playTitleBG,titleScreenButton,scoreManager
local function titleScreen()
    composer.gotoScene( "scripts.scenes.titleScreen" )
end
 
-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
 
-- create()
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
        backGroup = display.newGroup()
        mainGroup = display.newGroup()

        scoreManager =  require("scripts.scoreManager")
        scoreManager.loadScores()
        titleBackGroundSound = audio.loadStream("assets/audio/highScore.mp3")
        background = display.newImageRect(
            backGroup,
            "assets/screens/gameover.png",
            1920,
            1080
        )
        background.x = display.contentCenterX
        background.y = display.contentCenterY
        title = display.newText(
            mainGroup,
            "High Score",
            display.contentCenterX,
            display.contentCenterY * 0.15,
            native.systemFont,
            88
        )
        title:setFillColor(
            0.82,
            0.86,
            1
        )
        scoreManager.print(mainGroup)
        exitButton   = display.newImageRect(mainGroup,"assets/elements/exitButton.png",200,100) 
        exitButton.x = display.contentCenterX
        exitButton.y = display.contentCenterY * 1.8
        playTitleBG = audio.play(titleBackGroundSound,{loops = -1})
        exitButton:addEventListener( "tap", titleScreen )

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
        scoreManager = nil
        display.remove(mainGroup)
        display.remove(backGroup)
        exitButton:removeEventListener( "tap", titleScreen )       
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