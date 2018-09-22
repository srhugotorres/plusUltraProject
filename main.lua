display.setStatusBar(display.HiddenStatusBar)

-- CONSTANT VALUES
_CX = display.contentWidth*0.5
_CY = display.contentHeight*0.5
_CW = display.contentWidth
_CH = display.contentHeight
_T = display.screenOriginY -- Top
_L = display.screenOriginX -- Left
_R = display.viewableContentWidth - _L -- Right
_B = display.viewableContentHeight - _T-- Bottom

-- hide the status bar
display.setStatusBar( display.HiddenStatusBar )


-- include composer
local composer = require "composer"

composer.gotoScene("titleScreen")
