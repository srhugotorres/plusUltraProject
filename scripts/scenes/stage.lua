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
local background,stageUI,ship,newShip,controller,objectsGenerator,generetor,stageBackGroundSound,playStageBG

-- sound

local function onCollision(event)
    if event.phase == "began" then
        if event.target.myName == "ship" and event.other.myName == "spaceObject" then
            composer.gotoScene("scripts.scenes.gameover", { time=2000, effect="crossFade" })
            
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
    
    
end

-- show()
function scene:show( event )
    
    local sceneGroup = self.view
    local phase = event.phase
    
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
        background = require "scripts.background"
        stageUI = require "scripts.stageUI"
        newShip = require "scripts.elements.ship"
        controller = require "scripts.controllerInterface"
        objectsGenerator = require "scripts.objectsGenerator"
        --
        stageBackGroundSound = audio.loadStream("assets/audio/backgroundsound.wav")

        background.new(
            backGroup,
            2048,
            2732
        )
        stageUI.run(uiGroup)
        playStageBG = audio.play(stageBackGroundSound,{loops = -1})
        -- Gamepad

        ship = newShip.new(mainGroup,"gamepadtouch")
        controller.runGamepadTouch(ship)
        
        -- Keyboard

        --ship = newShip.new(mainGroup,"keyboard")
        --controller.runKeyboard(ship)
        --
        generate = objectsGenerator.run(mainGroup)
           
        ship.getShip():addEventListener( "collision", onCollision )
    end
end
 
 
-- hide()
function scene:hide( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is on screen (but is about to go off screen)
 
        audio.stop(playStageBG)
        ship.getShip():removeEventListener( "collision", onCollision )
        background = nil
        stageUI = nil
        ship = nil
        newShip = nil
        controller = nil
        stageBackGroundSound = nil
        playStageBG = nil
    elseif ( phase == "did" ) then
        -- Code here runs immediately after the scene goes entirely off screen
        timer.cancel(generate)
        objectsGenerator.stop()
        objectsGenerator = nil
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