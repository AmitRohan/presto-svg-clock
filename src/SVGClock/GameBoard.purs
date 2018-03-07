module SVGClock.GameBoard where

import Prelude (Unit, bind, (-))

import Control.Monad.Eff (Eff)
import Data.Number.Format (toString)
import Ester.Types (GameBoard(..), SVG(..), SvgName(..))
import Ester.Utils as Utils
import Ester.Props (_id, d, cx, cy, fill, height, radius, stroke, stroke_width, width, x, x1, x2, y, y1, y2)
import SVGClock.GameConfig as GameConfig
import SVGClock.Types (GameState)

-- | This Function enables a layout with id 'gameBoard' to draw SVG
initBoard :: forall t. Eff t Unit
initBoard = Utils.initGameBoard ( GameBoard { id : "gameBoard", height : GameConfig.boardHeight, width : GameConfig.boardWidth } )

-- | This Function add base objects needed for the clock
addBaseWorld :: forall t. GameState -> Eff t Unit
addBaseWorld state = do
	
	-- Calculates the starting cordinates of the clock hands using dimensions in state	
	let sStart = state.clockDimen.cy - state.secondHandDimen.length
	let mStart = state.clockDimen.cy - state.minuteHandDimen.length
	let hStart = state.clockDimen.cy - state.hourHandDimen.length

	-- Make a backgroud for our Game Board.
	_ <- Utils.addGameObject (SvgName "World") (SVG { name : "Background", nodeType : "Rectangle" , props : [ 
	  height (toString GameConfig.boardHeight),
	  width (toString GameConfig.boardWidth),
	  x "0",
	  y "0",
	  fill "#90CAF9"
	]})
	 
	-- Hollow Path to follow
	_ <- Utils.addGameObject (SvgName "World") (SVG { name : "DropPath", nodeType : "Path" , props : [ 
	  _id "pathToFollow",
	  d "M10,90 C5,5 490,5 490,90 ",
	  stroke "#123123",
	  fill "none",
	  stroke_width "2px"
	]}) 

	-- Make a Rectangle for our box using dimensions in config.
	Utils.addGameObject (SvgName "World") (SVG { name : "ClockBody", nodeType : "Rectangle" , props : [ 
	  _id "bodyClock",
	  x ( toString 0.0 ),
	  y ( toString 0.0 ),
	  height ( toString state.clockDimen.radius ),
	  width ( toString state.clockDimen.radius ),
	  fill "#20B7AF",
	  stroke "#FFFFFF",
	  stroke_width "2px"
	]}) 

