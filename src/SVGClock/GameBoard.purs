module SVGClock.GameBoard where

import Prelude (Unit, bind)

import Control.Monad.Eff (Eff)
import Data.Number.Format (toString)
import Ester.Types (GameBoard(..), SVG(..), SvgName(..))
import Ester.Utils as Utils
import Ester.Props (_id, cx, cy, fill, height, radius, stroke, stroke_width, transform, width, x, x1, x2, y, y1, y2)
import SVGClock.GameConfig as GameConfig

initBoard :: forall t. Eff t Unit
initBoard = Utils.initGameBoard ( GameBoard { id : "gameBoard", height : GameConfig.boardHeight, width : GameConfig.boardWidth } )

addBaseWorld :: forall t. Eff t Unit
addBaseWorld = do
	let boardWidth = GameConfig.boardWidth
	let boardHeight = GameConfig.boardHeight
	
	_ <- Utils.addGameObject (SvgName "World") (SVG { name : "Background", nodeType : "Rectangle" , props : [ 
	  height (toString boardHeight),
	  width (toString boardWidth),
	  x "0",
	  y "0",
	  fill "#90CAF9"
	]})
	 
	_ <- Utils.addGameObject (SvgName "World") (SVG { name : "ClockBody", nodeType : "Circle" , props : [ 
	  _id "bodyClock",
	  cx "100",
	  cy "100",
	  radius "80",
	  fill "#20B7AF",
	  stroke "#FFFFFF",
	  stroke_width "12px"
	]}) 

	_ <- Utils.addGameObject (SvgName "World") (SVG { name : "Hourhand", nodeType : "Line" , props : [ 
	  _id "hourHand",
	  x1 "100",
	  y1 "100",
	  x2 "100",
	  y2 "55",
	  transform "rotate(45 100 100)",
	  stroke "#fffbf9",
	  stroke_width "3px"
	]}) 

	_ <- Utils.addGameObject (SvgName "World") (SVG { name : "MinuteHand", nodeType : "Line" , props : [ 
	  _id "minuteHand",
	  x1 "100",
	  y1 "100",
	  x2 "100",
	  y2 "40",
	  transform "rotate(180 100 100)",
	  stroke "#fffbf9",
	  stroke_width "4px"
	]}) 

	_ <- Utils.addGameObject (SvgName "World") (SVG { name : "SecondHand", nodeType : "Line" , props : [ 
	  _id "secondHand",
	  x1 "100",
	  y1 "100",
	  x2 "100",
	  y2 "30",
	  stroke "#fffbf9",
	  stroke_width "3px"
	]}) 

	Utils.addGameObject (SvgName "World") (SVG { name : "MidScrew", nodeType : "Circle" , props : [ 
	  _id "midScrew",
	  cx "100",
	  cy "100",
	  radius "3",
	  fill "#128A86",
	  stroke "#C1EFED",
	  stroke_width "2px"
	]})
