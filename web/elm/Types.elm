module Types exposing (..)


type alias Model =
    {}


type Msg
    = Something


init : ( Model, Cmd Msg )
init =
    ( Model, Cmd.none )
