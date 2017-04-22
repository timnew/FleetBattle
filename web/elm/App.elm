module App exposing (main)

import Html exposing (..)


type alias Model =
    {}


type Msg
    = Something


init : ( Model, Cmd Msg )
init =
    ( Model, Cmd.none )


view : Model -> Html Msg
view model =
    text "Bare start"


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
