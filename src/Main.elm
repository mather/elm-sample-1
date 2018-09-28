module Main exposing (main)

import Html exposing (Html, text)
import Browser

main: Program () Model Msg 
main = Browser.sandbox 
  { init = init
  , update = update
  , view = view
  }

type alias Model =
  { timeline: Timeline }

type alias Tweet = 
  { message: String
  , username: String
  }

type alias Timeline = List Tweet

init : Model
init = 
  { timeline = [] }

type Msg =
  NoOp
  
update : Msg -> Model -> Model
update msg model =
  case msg of 
    NoOp ->
      model
      

view : Model -> Html Msg
view model =
    text "Hello, world!"
