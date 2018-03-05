module Ester.Props where

import Ester.Types (Property(..))

_id :: String -> Property
_id v = Property { key : "id" , value : v }

height :: String -> Property
height v = Property { key : "height" , value : v }

width :: String -> Property
width v = Property { key : "width" , value : v }

x :: String -> Property
x v = Property { key : "x" , value : v }

y :: String -> Property
y v = Property { key : "y" , value : v }

x1 :: String -> Property
x1 v = Property { key : "x1" , value : v }

y1 :: String -> Property
y1 v = Property { key : "y1" , value : v }

x2 :: String -> Property
x2 v = Property { key : "x2" , value : v }

y2 :: String -> Property
y2 v = Property { key : "y2" , value : v }

cx :: String -> Property
cx v = Property { key : "cx" , value : v }

cy :: String -> Property
cy v = Property { key : "cy" , value : v }

radius :: String -> Property
radius v = Property { key : "r" , value : v }

fill :: String -> Property
fill v = Property { key : "fill" , value : v }

stroke :: String -> Property
stroke v = Property { key : "stroke" , value : v }

stroke_width :: String -> Property
stroke_width v = Property { key : "stroke-width" , value : v }

transform :: String -> Property
transform v = Property { key : "transform" , value : v }