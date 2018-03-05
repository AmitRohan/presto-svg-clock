module SVGClock.Types where

-- | A type for the Clock Model. This will be used to plot the Clock on board
type ClockModel = { radius :: Number , cx :: Number , cy :: Number }

-- | [ Length , Width ] structuere for clock
type Dimen = { length :: Number , width :: Number }

-- | A type for the game state. Consists all the data in the game
type GameState =
  { gameTime :: Number
  	, clockDimen :: ClockModel
    , secondHandDimen :: Dimen
    , minuteHandDimen :: Dimen
    , hourHandDimen :: Dimen 
  }
