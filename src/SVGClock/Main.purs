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
import Prelude (Unit, bind, pure, unit, (*>), (<$>), (+), (/), (#), ($), negate)
import PrestoDOM.Core (PrestoDOM)
import PrestoDOM.Elements (linearLayout)
import PrestoDOM.Properties (id_, height, width, background)
import PrestoDOM.Types 
import PrestoDOM.Util (render)

-- | This layout is created using PrestorDom. We will be using this layout as base 
-- | to render our svg objects.
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
    -- Declare a init State for our Game , in this case our clock
    let initialState = GameConfig.initState

    -- Render the Game Board with out initial state
    { stateBeh, updateState } <- render gameBoard initialState

    -- Inititalise our Layout to render SVG. For now we are using layout with id "gameBoard"
    _ <- GameBoard.initBoard 

    -- Add clock elements to our world
    _ <- GameBoard.addBaseWorld initialState

    let strartFollow = Animation.getById (Animation.IDi "bodyClock")
                    # Animation._startFollowAnimation (Animation.IDi "pathToFollow") (negate 1.0)

    -- Update the clock based on State.
    updateState (eval <$> stateBeh) animationFrame *>
    pure unit

-- | The eval function is the function that gets called whenever a UI event occurred. In our case, the only event we
-- | are calling this is with is the animationFrame event which repeatedly occurs when in browser animation frame is
-- | granted for us. And yes, this uses `window.requestAnimationFrame` under the hood.
eval :: GameState -> GameState
eval state = do
  -- Update the clock time in the state
  let gt = state.gameTime + 1.0
  -- Get object references to SVG objects using the ID specified in GameBoard
  -- and rotate the Clock hands based on time

  -- let animateSS = Animation.getById (Animation.IDi "secondHand")
  --                   # Animation._rotateAt (Animation.Vi gt) 100.0 100.0
  -- let animateMM = Animation.getById (Animation.IDi "minuteHand")
  --                   # Animation.rotateAt (Animation.Vi (gt/60.0) ) 100.0 100.0
  -- let animateHH = Animation.getById (Animation.IDi "hourHand")
  --                   # Animation.rotateAt (Animation.Vi (gt/3600.0) ) 100.0 100.0
  
  -- Update the state variable and return it for next eval
  state { gameTime = gt }

