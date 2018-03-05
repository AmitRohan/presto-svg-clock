module Ester.Utils where

{- helper functions to render svg game objects and update them -}

import Prelude (Unit)

import FRP.Event (Event)
import Ester.Types (Collision, GameBoard, Property(..), PropertyList, SVG, SvgName, SvgNameCache)
import Control.Monad.Eff (Eff)

foreign import logAny :: forall a. a -> Unit

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

