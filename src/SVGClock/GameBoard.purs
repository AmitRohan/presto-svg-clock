module SVGClock.GameBoard where

import Prelude (Unit, bind, (-))

import Control.Monad.Eff (Eff)
import Data.Number.Format (toString)
import Ester.Types (GameBoard(..), SVG(..), SvgName(..))
import Ester.Utils as Utils
import Ester.Props (_id, cx, cy, fill, height, radius, stroke, stroke_width, width, x, x1, x2, y, y1, y2)
import SVGClock.GameConfig as GameConfig
import SVGClock.Types (GameState)

-- | This Function enables a layout with id 'gameBoard' to draw SVG
initBoard :: forall t. Eff t Unit
initBoard = Utils.initGameBoard ( GameBoard { id : "gameBoard", height : GameConfig.boardHeight, width : GameConfig.boardWidth } )

-- | This Function add base objects needed for the clock
addBaseWorld :: forall t. GameState -> Eff t Unit
addBaseWorld state = do
	let boardWidth = GameConfig.boardWidth
	let boardHeight = GameConfig.boardHeight
	
	-- Starting Cordinates are calculates using the length specified in the config
	let sStart = state.clockDimen.cy - state.secondHandDimen.length
	let mStart = state.clockDimen.cy - state.minuteHandDimen.length
	let hStart = state.clockDimen.cy - state.hourHandDimen.length

	_ <- Utils.addGameObject (SvgName "World") (SVG { name : "Background", nodeType : "Rectangle" , props : [ 
	  height (toString boardHeight),
	  width (toString boardWidth),
	  x "0",
	  y "0",
	  fill "#90CAF9"
	]})
	 
	-- Draws the Back of our watch 
	_ <- Utils.addGameObject (SvgName "World") (SVG { name : "ClockBody", nodeType : "Circle" , props : [ 
	  _id "bodyClock",
	  cx ( toString state.clockDimen.cx ),
	  cy ( toString state.clockDimen.cy ),
	  radius ( toString state.clockDimen.radius ),
	  fill "#20B7AF",
	  stroke "#FFFFFF",
	  stroke_width "12px"
	]}) 

	_ <- Utils.addGameObject (SvgName "World") (SVG { name : "Hourhand", nodeType : "Line" , props : [ 
	  _id "hourHand",
	  x1 ( toString state.clockDimen.cx ),
	  y1 ( toString state.clockDimen.cy ),
	  x2 ( toString state.clockDimen.cx ),
	  y2 ( toString hStart ),
	  stroke "#fffbf9",
	  stroke_width ( toString state.hourHandDimen.width )
	]}) 

	_ <- Utils.addGameObject (SvgName "World") (SVG { name : "MinuteHand", nodeType : "Line" , props : [ 
	  _id "minuteHand",
	  x1 ( toString state.clockDimen.cx ),
	  y1 ( toString state.clockDimen.cy ),
	  x2 ( toString state.clockDimen.cx ),
	  y2 ( toString mStart ),
	  stroke "#fffbf9",
	  stroke_width ( toString state.minuteHandDimen.width )
	]}) 

	_ <- Utils.addGameObject (SvgName "World") (SVG { name : "SecondHand", nodeType : "Line" , props : [ 
	  _id "secondHand",
	  x1 ( toString state.clockDimen.cx ),
	  y1 ( toString state.clockDimen.cy ),
	  x2 ( toString state.clockDimen.cx ),
	  y2 ( toString sStart ),
	  stroke "#fffbf9",
	  stroke_width ( toString state.secondHandDimen.width )
	]}) 

	Utils.addGameObject (SvgName "World") (SVG { name : "MidScrew", nodeType : "Circle" , props : [ 
	  _id "midScrew",
	  cx ( toString state.clockDimen.cx ),
	  cy ( toString state.clockDimen.cy ),
	  radius "3",
	  fill "#128A86",
	  stroke "#C1EFED",
	  stroke_width "2px"
	]})
