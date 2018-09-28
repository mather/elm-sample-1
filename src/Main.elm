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
    , username : String
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


init : Model
init =
    { timeline = emptyTimeline
    , username = ""
    , message = ""
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
            { model | username = username }

        UpdateMessage message ->
            { model | message = message }

        AddTweet tweet ->
            { model | timeline = tweet :: model.timeline, message = "" }


view : Model -> Html Msg
view model =
    div []
        [ viewUsernameInput model.username
        , viewMessageInput model.message
        , viewTweetButton model
        , viewTimeline model.timeline
        ]


viewUsernameInput : String -> Html Msg
viewUsernameInput username =
    div []
        [ text "Username: "
        , input [ value username, onInput UpdateUsername ] []
        ]


viewMessageInput : String -> Html Msg
viewMessageInput message =
    div []
        [ text "Message: "
        , input [ value message, onInput UpdateMessage ] []
        ]


viewTweetButton : Model -> Html Msg
viewTweetButton model =
    let
        tweet =
            { username = model.username, message = model.message }

        tweetDisabled =
            String.isEmpty model.username || String.isEmpty model.message
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
