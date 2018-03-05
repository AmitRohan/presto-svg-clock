module SVGClock.Types where

-- | [ Length , Width ] structuere 
type Dimen = Array (Number)

-- | A type for the game state. Consists all the data in the game
type GameState =
  { gameTime :: Number
    , secondHandDimen :: Dimen
    , minuteHandDimen :: Dimen
    , hourHandDimen :: Dimen 
  }
