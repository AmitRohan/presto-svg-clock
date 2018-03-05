module SVGClock.Main where

import SVGClock.GameConfig as GameConfig
import SVGClock.GameBoard as GameBoard
import SVGClock.Types (GameState)
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Console (CONSOLE)
import Ester.Animation as Animation
import DOM (DOM)
import FRP (FRP)
import FRP.Event.Time (animationFrame)
import Prelude (Unit, bind, pure, unit, (*>), (<$>), (+), (/))
import PrestoDOM.Core (PrestoDOM)
import PrestoDOM.Elements (linearLayout)
import PrestoDOM.Properties (id_, height, width, background)
import PrestoDOM.Types 
import PrestoDOM.Util (render)

-- | This layout is created using PrestorDom. We will be using this layout as base 
-- | to render our svg objects
gameBoard :: forall i p. GameState -> PrestoDOM i p
gameBoard state = linearLayout
                    [ id_ "gameBoard"
                    , height Match_Parent
                    , width Match_Parent
                    , background "#FFFFFF"
                    ]
                    [
                    ] 


-- | The entry point of the game. Here we initialize the state, create the entities,
-- | and start rendering the game
main :: forall e. Eff (dom :: DOM, console :: CONSOLE, frp :: FRP | e) Unit
main = do
    let initialState = GameConfig.initState
    { stateBeh, updateState } <- render gameBoard initialState
    _ <- GameBoard.initBoard 
    _ <- GameBoard.addBaseWorld initialState
    updateState (eval <$> stateBeh) animationFrame *>
    pure unit

-- | The eval function is the function that gets called whenever a UI event occurred. In our case, the only event we
-- | are calling this is with is the animationFrame event which repeatedly occurs when in browser animation frame is
-- | granted for us. And yes, this uses `window.requestAnimationFrame` under the hood.
eval :: GameState -> GameState
eval state = do
  let gt = state.gameTime + 1.0
  let secondHand = Animation.getById (Animation.IDi "secondHand")
  let minuteHand = Animation.getById (Animation.IDi "minuteHand")
  let hourHand = Animation.getById (Animation.IDi "hourHand")
  let animateSS = Animation.rotateAt (Animation.Vi gt) 100.0 100.0 (Animation.Ti 0.0) secondHand
  let animateMM = Animation.rotateAt (Animation.Vi (gt/60.0) ) 100.0 100.0 (Animation.Ti 0.0) minuteHand
  let animateHH = Animation.rotateAt (Animation.Vi (gt/3600.0) ) 100.0 100.0 (Animation.Ti 0.0) hourHand
  state { gameTime = gt }

