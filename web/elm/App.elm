module App exposing (main)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Svg
import Svg.Attributes exposing (xlinkHref)


--
-- type CellStatus
--     = Blank
--     | Ship
--     | Wreck


type Cell
    = Blank Int
    | Ship Int
    | Wreck Int


type Force
    = Mine
    | Yours


type alias Grid =
    List Cell


newGrid : Force -> Cell -> Grid
newGrid force prototype =
    let
        cellConstructor =
            case prototype of
                Blank _ ->
                    Blank

                Ship _ ->
                    Ship

                Wreck _ ->
                    Wreck
    in
        (List.range 0 15) |> List.map cellConstructor


type alias Model =
    { mineGrid : Grid
    , yourGrid : Grid
    }


type Msg
    = PlaceAt Int
    | BombAt Int


placeAt : Int -> Model -> Model
placeAt index model =
    model


bombAt : Int -> Model -> Model
bombAt index model =
    model


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        PlaceAt index ->
            ( placeAt index model, Cmd.none )

        BombAt index ->
            ( bombAt index model, Cmd.none )


init : ( Model, Cmd Msg )
init =
    ( (Model (newGrid Mine (Blank 0)) (newGrid Yours (Ship 0)))
    , Cmd.none
    )


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


message_creator : Force -> Int -> Msg
message_creator force index =
    case force of
        Yours ->
            BombAt index

        Mine ->
            PlaceAt index


cellWrapper : (Int -> Msg) -> Int -> List (Html Msg) -> Html Msg
cellWrapper message index children =
    div [ class "cell", onClick (message index) ] children


cell : (Int -> Msg) -> Cell -> Html Msg
cell message cell =
    case cell of
        Ship index ->
            cellWrapper message
                index
                [ Svg.svg
                    [ Svg.Attributes.class "icon" ]
                    [ Svg.use [ xlinkHref "#icon-ship" ] []
                    ]
                ]

        Wreck index ->
            cellWrapper message
                index
                [ Svg.svg
                    [ Svg.Attributes.class "icon" ]
                    [ Svg.use [ xlinkHref "#icon-wreck" ] []
                    ]
                ]

        Blank index ->
            cellWrapper message
                index
                []


grid : Force -> Grid -> Html Msg
grid force cells =
    let
        cellRender =
            cell (message_creator force)
    in
        div [ class ("grid " ++ class_for force) ] (List.map cellRender cells)


root : Model -> Html Msg
root { mineGrid, yourGrid } =
    div [ class "game" ]
        [ grid Mine mineGrid
        , grid Yours yourGrid
        ]


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = root
        , update = update
        , subscriptions = subscriptions
        }
