module SVGClock.GameConfig where

import SVGClock.Types (GameState)

-- | This fucntion returns the WIDTH of our GameBoard
boardWidth :: Number
boardWidth = 900.0

-- | This fucntion returns the HEIGHT of our GameBoard
boardHeight :: Number
boardHeight = 500.0

-- | This fucntion creates and returns the dafult state
initState :: GameState
initState =
  { 
    gameTime : 0.0 
    , secondHandDimen : [ 10.0 , 1.0 ]
    , minuteHandDimen : [ 7.0 , 1.0 ]
    , hourHandDimen : [ 5.0 , 1.0 ]
  }


