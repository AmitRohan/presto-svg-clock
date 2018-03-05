module SVGClock.GameUI where

import SVGClock.Types (GameState)
import SVGClock.GameConfig as GameConfig 
import Data.Number.Format (toString)
import Prelude ((/), (<>))
import PrestoDOM.Core (PrestoDOM)
import PrestoDOM.Elements (linearLayout, relativeLayout, textView)
import PrestoDOM.Properties (background, color, fontStyle, gravity, height, id_, margin, orientation, padding, text, textSize, weight, width)
import PrestoDOM.Types (Length(..))

windowScreen :: forall i p. GameState -> PrestoDOM i p
windowScreen state = linearLayout
              [ id_ "gameScreen"
              , height Match_Parent
              , width Match_Parent
              , orientation "vertical"
              ]
              [   getTopPane state
                , getMidPane state
              ]              

getTopPane::forall i p. GameState -> PrestoDOM i p
getTopPane state = linearLayout
                        [ id_ "topPane"
                        , height (V 70)
                        , width Match_Parent
                        , background "#000000"
                        , gravity "center_vertical"
                        , padding "20,20,20,20"
                        ]
                        [ 
                          textView
                             [
                                id_ "gameName"
                              , height (V 30)
                              , width (V 200)
                              , text "Presto SVG Clock"
                              , fontStyle "Source Sans Pro-Regular"
                              , textSize "25"
                              , color "#FFFFFF"
                             ]
                          , linearLayout [ height Match_Parent, width (V 0), weight "1"] []   
                          , textView
                             [
                                id_ "timeSpent"
                              , height (V 30)
                              , width (V 200)
                              , text _timeLeft
                              , margin "0,0,20,0" 
                              , fontStyle "Source Sans Pro-Regular"
                              , textSize "22"
                              , gravity "end"
                              , color "#FFFFFF"
                             ]  
                        ] where 
                            _timeLeft = "Time elapsed : " <> toString ( state.gameTime / 100.0 )


                    
getMidPane :: forall i p. GameState -> PrestoDOM i p
getMidPane state = linearLayout
                        [ id_ "midPane"
                        , height Match_Parent
                        , width Match_Parent
                        , gravity "center"
                        , background "#ff1744"
                        ]
                        [
                          relativeLayout
                          [ id_ "myBoards"
                          , height (V GameConfig.boardHeightInt )
                          , width (V GameConfig.boardWidthInt )
                          ]
                          [ 
                            linearLayout
                            [ id_ "gameBoard"
                            , height Match_Parent
                            , width Match_Parent
                            , background "#FFFFFF"
                            ]
                            [
                            ] 
                          ]
                        ]




                  
