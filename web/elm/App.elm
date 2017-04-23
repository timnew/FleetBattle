module App exposing (main)

import Html exposing (..)
import Svg
import Svg.Attributes exposing (xlinkHref)
import Html.Attributes exposing (..)


type alias Player =
    String


type Cell
    = Blank
    | Ship
    | Wreck


type Force
    = Mine
    | Yours


type alias Grid =
    { force : Force
    , cells : List Cell
    }


newGrid : Force -> Grid
newGrid force =
    { force = force
    , cells = List.repeat (4 * 4) Blank
    }


type alias Model =
    { players : ( Player, Player )
    , grids : ( Grid, Grid )
    }


type Msg
    = Something


init : ( Model, Cmd Msg )
init =
    ( Model ( "Mine", "Yours" ) ( newGrid (Mine), newGrid (Yours) )
    , Cmd.none
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


class_for : Force -> String
class_for force =
    case force of
        Yours ->
            "yours"

        Mine ->
            "mine"


cell : Cell -> Html Msg
cell cell =
    let
        children =
            case cell of
                Ship ->
                    [ Svg.svg
                        [ Svg.Attributes.class "icon" ]
                        [ Svg.use [ xlinkHref "#icon-ship" ] []
                        ]
                    ]

                Wreck ->
                    [ Svg.svg
                        [ Svg.Attributes.class "icon" ]
                        [ Svg.use [ xlinkHref "#icon-wreck" ] []
                        ]
                    ]

                Blank ->
                    []
    in
        div [ class "cell" ] children


grid : Grid -> Html Msg
grid { force, cells } =
    div [ class ("grid " ++ class_for force) ] (List.map cell cells)


root : Model -> Html Msg
root { players, grids } =
    let
        ( player1, player2 ) =
            players

        ( grid1, grid2 ) =
            grids
    in
        div [ class "game" ]
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
