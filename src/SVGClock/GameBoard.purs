module SVGClock.GameBoard where

import Prelude (Unit, bind, (*), (+), (-), (/), (<>))

import Control.Monad.Eff (Eff)
import Data.Number.Format (toString)
import Ester as Ester
import Ester.Animation as Animation
import SVGClock.Types
import SVGClock.GameConfig as GameConfig

initBoard :: forall t. Eff t Unit
initBoard = Ester.initGameBoard ( Ester.GameBoard { id : "gameBoard", height : GameConfig.boardHeight, width : GameConfig.boardWidth } )

addBaseWorld :: forall t. Eff t Unit
addBaseWorld = do
	let boardWidth = GameConfig.boardWidth
	let boardHeight = GameConfig.boardHeight
	
	_ <- Ester.addGameObject (Ester.SvgName "World") (Ester.Node { name : "Background", nodeType : "Rectangle" , props : [ 
	  Ester.getProp "height" (toString boardHeight),
	  Ester.getProp "width" (toString boardWidth),
	  Ester.getProp "x" "0",
	  Ester.getProp "y" "0",
	  Ester.getProp "fill" "#90CAF9"
	]})
	 
	_ <- Ester.addGameObject (Ester.SvgName "World") (Ester.Node { name : "ClockBody", nodeType : "Circle" , props : [ 
	  Ester.getProp "id" "bodyClock",
	  Ester.getProp "cx" "100",
	  Ester.getProp "cy" "100",
	  Ester.getProp "r" "80",
	  Ester.getProp "fill" "#20B7AF",
	  Ester.getProp "stroke" "#FFFFFF",
	  Ester.getProp "stroke-width" "12px"
	]}) 

	_ <- Ester.addGameObject (Ester.SvgName "World") (Ester.Node { name : "Hourhand", nodeType : "Line" , props : [ 
	  Ester.getProp "id" "hourHand",
	  Ester.getProp "x1" "100",
	  Ester.getProp "y1" "100",
	  Ester.getProp "x2" "100",
	  Ester.getProp "y2" "55",
	  Ester.getProp "transform" "rotate(45 100 100)",
	  Ester.getProp "stroke" "#fffbf9",
	  Ester.getProp "stroke-width" "3px"
	]}) 

	_ <- Ester.addGameObject (Ester.SvgName "World") (Ester.Node { name : "MinuteHand", nodeType : "Line" , props : [ 
	  Ester.getProp "id" "minuteHand",
	  Ester.getProp "x1" "100",
	  Ester.getProp "y1" "100",
	  Ester.getProp "x2" "100",
	  Ester.getProp "y2" "40",
	  Ester.getProp "transform" "rotate(180 100 100)",
	  Ester.getProp "stroke" "#fffbf9",
	  Ester.getProp "stroke-width" "4px"
	]}) 

	_ <- Ester.addGameObject (Ester.SvgName "World") (Ester.Node { name : "SecondHand", nodeType : "Line" , props : [ 
	  Ester.getProp "id" "secondHand",
	  Ester.getProp "x1" "100",
	  Ester.getProp "y1" "100",
	  Ester.getProp "x2" "100",
	  Ester.getProp "y2" "30",
	  Ester.getProp "stroke" "#fffbf9",
	  Ester.getProp "stroke-width" "3px"
	]}) 

	Ester.addGameObject (Ester.SvgName "World") (Ester.Node { name : "MidScrew", nodeType : "Circle" , props : [ 
	  Ester.getProp "id" "midScrew",
	  Ester.getProp "cx" "100",
	  Ester.getProp "cy" "100",
	  Ester.getProp "r" "3",
	  Ester.getProp "fill" "#128A86",
	  Ester.getProp "stroke" "#C1EFED",
	  Ester.getProp "stroke-width" "2px"
	]})



-- Update The Object based on id and model
-- patchBoard:: forall t . String -> ClockModel -> Eff t Unit
-- patchBoard objectName (Model objectModel) = 
-- 	Ester.modifyGameObject (Ester.SvgName objectName) (Ester.PropertyList propList) 
-- 		where
-- 			propList = [
-- 					    Ester.getProp "x" newX ,
-- 					    Ester.getProp "y" newY
-- 					  ]
-- 			newY = toString ( objectModel.y )
-- 			newX = toString ( objectModel.x )   					  

addRectangle ::  forall t. String -> String -> String -> String -> String -> String -> Eff t Unit
addRectangle _name x y width height color = Ester.addGameObject (Ester.SvgName "Obstacles") (Ester.Node { name : _name, nodeType : "Rectangle" , props : [ 
	  Ester.getProp "height" height,
	  Ester.getProp "width" width,
	  Ester.getProp "x" x,
	  Ester.getProp "y" y ,
	  Ester.getProp "fill" color
	]})