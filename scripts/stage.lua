local composer = require( "composer" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
-- Group 
local backGroup = display.newGroup()
local mainGroup = display.newGroup()
local uiGroup = display.newGroup()

-- require
local background = require "scripts.background"
local newShip = require "scripts.elements.ship"
local controller = require "scripts.controllerInterface"
local objectsGenerator = require "scripts.objectsGenerator"
local stageUI = require "scripts.stageUI"
-- sound

local stageBackGroundSound = audio.loadStream("assets/audio/backgroundsound.wav")
local playStageBG = audio.play(stageBackGroundSound)

local function onCollision(event)
    if event.phase == "began" then
        if event.target.myName == "ship" and event.other.myName == "spaceObject" then
            print("teste")
            audio.stop(playStageBG)
            stageBackGroundSound = nil
            playStageBG = nil 
            composer.gotoScene("scripts.gameover")
        end
    end
end

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen
    background.new(
        backGroup,
        2048,
        2732
    )
    stageUI.run(uiGroup)
    --local ship = newShip.new(mainGroup,"gamepadtouch")
    --controller.runGamepadTouch(ship)
    local ship = newShip.new(mainGroup,"keyboard")
    controller.runKeyboard(ship)

    objectsGenerator.run(mainGroup)
    ship.getShip():addEventListener( "collision", onCollision )
end

-- show()
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
 
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