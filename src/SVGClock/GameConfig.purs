module SVGClock.GameConfig where
-- Frame Rate and Tick Interval
import Prelude ((+), (/))
import SVGClock.Types (GameInterval, GameTime, GameState)

-- | State of the game at start. Creates the entities, and initializes the game state to the default.
initState :: GameState
initState =
  { 
    gameTime : 0.0 
    , secondHandDimen : [ 10.0 , 1.0 ]
    , minuteHandDimen : [ 7.0 , 1.0 ]
    , hourHandDimen : [ 5.0 , 1.0 ]
  }

boardWidth :: Number
boardWidth = 900.0

boardWidthInt :: Int
boardWidthInt = 900

boardHeight :: Number
boardHeight = 500.0

boardHeightInt :: Int
boardHeightInt = 500

framesPerSercondInt :: Int
framesPerSercondInt = 1000

framesPerSercond :: Number
framesPerSercond = 1000.0

tickInterval :: GameInterval
tickInterval = 1000.0 / framesPerSercond

tickIntervalInt :: Int
tickIntervalInt = 1000 / framesPerSercondInt

tick:: GameTime -> GameTime
tick gameTime = gameTime + tickInterval

tickAt:: GameTime -> GameInterval -> GameTime
tickAt gameTime interval = gameTime + interval

baseTick :: GameTime
baseTick = 0.0
