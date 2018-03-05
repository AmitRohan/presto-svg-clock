module SVGClock.Types where

-- Time Spent In The Game ( update acc to interval )
type GameTime = Number
type GameInterval = Number

-- | [ Length , Width ] structuere 
type Dimen = Array (Number)

-- | A type for the game state. Consists all the data in the game
type GameState =
  { gameTime :: Number
    , secondHandDimen :: Dimen
    , minuteHandDimen :: Dimen
    , hourHandDimen :: Dimen 
  }
