module SVGClock.GameConfig where

import SVGClock.Types (GameState)

-- | This fucntion returns the WIDTH of our GameBoard
boardWidth :: Number
boardWidth = 1100.0

-- | This fucntion returns the HEIGHT of our GameBoard
boardHeight :: Number
boardHeight = 700.0

-- | This fucntion creates and returns the dafult state
initState :: GameState
initState =
  { 
    gameTime : 0.0 
    , clockDimen : { radius : 80.0 , cx : 100.0 , cy : 100.0 }
    , secondHandDimen 	: { length : 70.0 	, width : 3.0 }
    , minuteHandDimen 	: { length : 60.0 	, width : 4.0 }
    , hourHandDimen 	: { length : 45.0 	, width : 3.0 }
  }


