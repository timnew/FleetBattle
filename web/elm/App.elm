module App exposing (main)

import Html exposing (..)
import Html.Attributes exposing (..)


type alias Player =
    String


type Cell
    = Blank
    | Ship Player
    | Damaged Player


type alias Grid =
    List Cell


newGrid : Grid
newGrid =
    List.repeat 9 Blank


type alias Model =
    { players : ( Player, Player )
    , grids : ( Grid, Grid )
    }


type Msg
    = Something


init : ( Model, Cmd Msg )
init =
    ( Model ( "P1", "P2" ) ( newGrid, newGrid )
    , Cmd.none
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


cell : Cell -> Html Msg
cell cell =
    div [ class "cell" ]
        [ text "cell"
        ]


grid : Grid -> Html Msg
grid gridData =
    div [ class "gird" ] (List.map cell gridData)


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
