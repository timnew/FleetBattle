module App exposing (main)

import Html exposing (..)


type alias Player =
    String


type Cell
    = Blank
    | Ship Player
    | Damaged Player


type alias Grid =
    List Cell


type alias Model =
    { players : ( Player, Player )
    , grids : ( Grid, Grid )
    }


type Msg
    = Something


init : ( Model, Cmd Msg )
init =
    ( Model ( "P1", "P2" ) ( List.repeat 8 Blank, List.repeat 8 Blank )
    , Cmd.none
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


grid : Grid -> Html Msg
grid gridData =
    text "Grid"


root : Model -> Html Msg
root { players, grids } =
    let
        ( player1, player2 ) =
            players

        ( grid1, grid2 ) =
            grids
    in
        div []
            [ grid grid1
            , grid grid2
            ]


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = root
        , update = update
        , subscriptions = subscriptions
        }
