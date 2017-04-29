module App exposing (..)

import Html exposing (Html, div, ul, li, text, program)
import List exposing (map)
import Graphics.Render exposing (Form, circle, solid, ellipse, filledAndBordered, position, svg)
import Color exposing (rgb)


type Terrain
    = Desert
    | Grasslands
    | Mountains
    | Jungle
    | Rainforests
    | Tundra


type alias Planet =
    { name : String
    , diameter : Int
    , terrain : Terrain
    }



-- MODEL


type alias Model =
    List Planet


init : ( Model, Cmd Msg )
init =
    ( [ { name = "Hoth", diameter = 7200, terrain = Tundra }
      , { name = "Tatooine", diameter = 10465, terrain = Desert }
      , { name = "Alderaan", diameter = 12500, terrain = Grasslands }
      ]
    , Cmd.none
    )



-- MESSAGES


type Msg
    = NoOp



-- VIEW


calculateSize : Int -> Float
calculateSize diameter =
    ((toFloat diameter) / 100)


colorForTerrain : Terrain -> Color.Color
colorForTerrain terrain =
    case terrain of
        Desert ->
            rgb 232 209 157

        Tundra ->
            rgb 155 203 219

        Grasslands ->
            rgb 138 183 113

        Mountains ->
            rgb 177 183 113

        Rainforests ->
            rgb 93 124 59

        Jungle ->
            rgb 93 124 59


redCircle : Int -> Terrain -> Form Msg
redCircle diameter terrain =
    ellipse (calculateSize diameter) (calculateSize diameter)
        |> filledAndBordered (solid <| (colorForTerrain terrain)) 1 (solid <| rgb 0 0 0)
        |> position ( 155, 155 )


view : Model -> Html Msg
view model =
    div []
        [ model
            |> List.map
                (\item ->
                    div []
                        [ Html.h1 [] [ Html.text item.name ]
                        , Html.p [] [ Html.text <| "Diameter: " ++ (toString item.diameter) ]
                        , Html.p [] [ Html.text <| "Terrain: " ++ (toString item.terrain) ]
                        , (redCircle item.diameter item.terrain) |> svg 200 200 310 310
                        ]
                )
            |> div []
        ]



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- MAIN


main : Program Never Model Msg
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
