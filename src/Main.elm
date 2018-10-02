module Main exposing (main)

import Browser
import Html exposing (Html, div, h2, input, li, text, ul)
import Html.Attributes exposing (disabled, type_, value)
import Html.Events exposing (onClick, onInput)


main : Program () Model Msg
main =
    Browser.sandbox
        { init = init
        , update = update
        , view = view
        }


type alias Model =
    { timeline : Timeline
    , inputForm : InputForm
    }


type alias InputForm =
    { username : String
    , message : String
    }


type alias Tweet =
    { message : String
    , username : String
    }


type alias Timeline =
    List Tweet


emptyTimeline : Timeline
emptyTimeline =
    []


emptyInputForm : InputForm
emptyInputForm =
    { username = ""
    , message = ""
    }


init : Model
init =
    { timeline = emptyTimeline
    , inputForm = emptyInputForm
    }


type Msg
    = NoOp
    | UpdateUsername String
    | UpdateMessage String
    | AddTweet Tweet


update : Msg -> Model -> Model
update msg model =
    case msg of
        NoOp ->
            model

        UpdateUsername username ->
            { model | inputForm = { username = username, message = model.inputForm.message } }

        UpdateMessage message ->
            { model | inputForm = { message = message, username = model.inputForm.username } }

        AddTweet tweet ->
            { model | timeline = tweet :: model.timeline, inputForm = { username = model.inputForm.username, message = "" } }


view : Model -> Html Msg
view model =
    div []
        [ viewInputForm model.inputForm
        , viewTweetButton model
        , viewTimeline model.timeline
        ]


viewInputForm : InputForm -> Html Msg
viewInputForm inputForm =
    ul []
        [ li []
            [ text "Username: "
            , input [ value inputForm.username, onInput UpdateUsername ] []
            ]
        , li []
            [ text "Message: "
            , input [ value inputForm.message, onInput UpdateMessage ] []
            ]
        ]


isEmptyInputForm : InputForm -> Bool
isEmptyInputForm inputForm =
    String.isEmpty inputForm.username || String.isEmpty inputForm.message


viewTweetButton : Model -> Html Msg
viewTweetButton model =
    let
        tweet =
            { username = model.inputForm.username
            , message = model.inputForm.message
            }

        tweetDisabled =
            isEmptyInputForm model.inputForm
    in
    div []
        [ input [ type_ "button", value "Tweet!", disabled tweetDisabled, onClick <| AddTweet tweet ] []
        ]


viewTimeline : Timeline -> Html Msg
viewTimeline timeline =
    let
        tweet2li tweet =
            li [] [ text <| tweet.message ++ "(" ++ tweet.username ++ ")" ]
    in
    div []
        [ h2 [] [ text "Timeline" ]
        , ul [] <|
            List.map tweet2li timeline
        ]
