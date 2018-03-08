module Ester.Utils where

{- helper functions to render svg game objects and update them -}

import Prelude 
import Prelude (Unit, ($), (+), (/))
import Data.Number.Format (toString)
import FRP.Event (Event)
import Ester.Types (Collision, GameBoard, IDi, Property(..), PropertyList, SVG, SVGAnimatedLength(..), SVGLength(..), SVGObject(..), SvgName, SvgNameCache, Transformation(..), Vi)
import Control.Monad.Eff (Eff)

foreign import initGameBoard :: forall eff . GameBoard -> Eff eff Unit
foreign import clearGameBoard :: forall eff . Eff eff Unit
foreign import getSvgNameCache :: forall eff . Eff eff SvgNameCache
foreign import addGameObject :: forall eff . SvgName -> SVG -> Eff eff Unit
foreign import getGameObjectProps :: forall eff . SvgName -> Eff eff PropertyList
foreign import detectCollision :: forall a c. a -> SvgName -> (Collision c)
foreign import modifyGameObject :: forall eff . SvgName -> PropertyList -> Eff eff Unit
foreign import removeGameObject :: forall eff . SvgName -> Eff eff Unit


foreign import keyController :: Event { keyCode :: Int }
foreign import joyStickPressController :: Event { keyCode :: Int }
foreign import joyStickReleaseController :: Event { keyCode :: Int }

getProp :: String -> String -> Property
getProp k v = Property { key : k , value : v }


-- | Returns SVGObject from DOM based on ID.
foreign import getById :: IDi -> SVGObject

-- | Applies transformation on SVGObject based on Param and Value
foreign import transform :: String -> Vi -> SVGObject -> SVGObject

-- | Rotate SVGObject on a pivot point with an Angle
foreign import rotateAt :: Vi -> Number -> Number -> SVGObject -> SVGObject

-- | Starts Follow Animation on Path with a repeat count ( -1 = infinite)
foreign import _followPath :: String -> Number-> SVGObject -> SVGObject

-- | Function to log any data
foreign import logAny :: forall a. a -> Unit


-- | Returns BaseValue of an SVGAnimatedLength Object
getBaseValues::SVGAnimatedLength -> SVGLength 
getBaseValues (SVGAnimatedLength v) = v.baseVal

-- | Returns AnimValue of an SVGAnimatedLength Object
getAnimValues::SVGAnimatedLength -> SVGLength 
getAnimValues (SVGAnimatedLength v) = v.animValue


-- | Returns the value of an SVGLength Object in NUMBER
getValue:: SVGLength -> Number 
getValue (SVGLength sl) = sl.value

-- | Returns the value of an SVGLength Object in STRING
getValueAsString:: SVGLength -> String 
getValueAsString (SVGLength sl) = sl.valueAsString

-- | Map Transformation To Params
mapParam :: Transformation -> String
mapParam Rotate  	= "rotate"
mapParam Scale  	= "scale"
mapParam ScaleX 	= "scaleX "
mapParam ScaleY 	= "scaleY "
mapParam SkewX		= "skewX"
mapParam SkewY		= "skewY"
-- mapParam _			= "rotate"
mapParam TranslateX	= "dx"
mapParam TranslateY	= "dy"

-- | Applies a Transformation with a Value over and SVGObject and returns and instance of modified object.
svgTransform :: Transformation -> Vi -> SVGObject -> SVGObject
svgTransform t v (SVGObject s) =  transform ( mapParam t) v (SVGObject s)


-- | Applies a Rotation Transformation ( pivot = by user ) with a Value over the SVGObject and returns an instance of the modified object.
_rotateAt::Vi -> Number -> Number -> SVGObject -> SVGObject
_rotateAt v cx cy s = do
	rotateAt v cx cy s

-- | Applies a Rotation Transformation ( pivot = center ) with a Value over the SVGObject and returns an instance of the modified object.
rotateAtCenter::Vi -> SVGObject -> SVGObject
rotateAtCenter v (SVGObject s) = rotateAt v fixX fixY (SVGObject s)
	where
		fixY = ( getValue $ getBaseValues $ s.y ) + heightFix
		fixX = ( getValue $ getBaseValues $ s.x ) + widthFix
		heightFix = ( getValue $ getBaseValues $ s.height ) / 2.0
		widthFix = ( getValue $ getBaseValues $ s.width ) / 2.0	


-- | For repeat count in follow Path
forever::Number
forever = negate 1.0

-- | Calculates a path for jump with a force in number
getJumpPath:: SVGObject -> Number -> String
getJumpPath (SVGObject s) jumpForce = "M" <> (toString _x1) <> "," <> (toString _y1) <> " " <> (toString _x1) <> "," <> (toString _y2) <> " z"
	where
		_y2 = _y1 - jumpForce
		_y1 = ( getValue $ getBaseValues $ s.y )
		_x1 = ( getValue $ getBaseValues $ s.x ) 

-- | Calculates a path for jump with a force in number
getVOsciPath:: SVGObject -> Number -> String
getVOsciPath (SVGObject s) maxAmp = "M" 
	<> (toString _x) <> "," <> (toString _y1) <> " " 
	<> (toString _x) <> "," <> (toString _y2) <> " " 
	<> (toString _x) <> "," <> (toString _y3) <> " " 
	<> (toString _x) <> "," <> (toString _y4) <> " " 
	<> (toString _x) <> "," <> (toString _y5) <> " " 
	<> (toString _x) <> "," <> (toString _y4) <> " " 
	<> (toString _x) <> "," <> (toString _y3) <> " " 
	<> (toString _x) <> "," <> (toString _y2) 
	<> " z"
		where
			_y5 = _y1 - maxAmp

			_y4 = _y2 + ( 0.5 * maxAmp)
			_y3 = _y1 - ( 0.5 * maxAmp)

			_y2 = _y1 - ( 2.0 * maxAmp)
			_y1 = ( getValue $ getBaseValues $ s.y ) + maxAmp
			
			_x = ( getValue $ getBaseValues $ s.x ) 


-- | Takes a Path to follow , Count ( forver for always running ) and an SVG OBJECT
followPath:: String -> Number -> SVGObject -> SVGObject
followPath path count s = do
	_followPath path count s
