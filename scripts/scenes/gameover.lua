local composer = require( "composer" )
local player = require "scripts.playerCreator"
local scene = composer.newScene()
local gameover, mainMenuButton,retryButton,scoresButton,background, gameoverBackgroundSound,gameOverCH

local function scoresGame()
    composer.gotoScene( "scripts.scenes.scores") 
end
local function retryGame()
    composer.gotoScene( "scripts.scenes.stage" )
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
        background = display.newImageRect(
            "assets/screens/gameover.png",
            1920,
            1080
        )
        background.x = display.contentCenterX
        background.y = display.contentCenterY

        gameover = display.newText(
            "Game Over",
            display.contentCenterX,
            display.contentCenterY,
            native.systemFont, 
            200 
        )
        gameover:setFillColor( 
            0.82, 
            0.86, 
            1 
        )

        scoresButton = display.newImageRect("assets/elements/scoresButton.png",200,100)
        scoresButton.x = display.contentCenterX * 1.4
        scoresButton.y = display.contentCenterY * 1.4

        retryButton = display.newImageRect("assets/elements/retryButton.png",200,100)
        retryButton.x = display.contentCenterX * 0.6
        retryButton.y = display.contentCenterY * 1.4

        gameoverBackgroundSound = audio.loadStream("assets/audio/gameover.wav")
        gameOverCH = audio.play(gameoverBackgroundSound,{loops = -1})

        scoresButton:addEventListener( "tap", scoresGame )
        retryButton:addEventListener( "tap", retryGame )
        
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
        display.remove(gameover)
        display.remove(scoresButton)
        display.remove(retryButton)
        display.remove(background)
        audio.stop(gameOverCH)
        player.eraseScore()
        gameoverBackgroundSound = nil
        gameover = nil
        scoresButton:removeEventListener("tap",scoresGame)
        retryButton:removeEventListener( "tap", retryGame )
 
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