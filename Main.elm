module App exposing (..)

import Html exposing (Html, div, ul, li, text, program)
import List exposing (map)
import Graphics.Render exposing (Form, circle, solid, ellipse, filledAndBordered, position, svg)
import Color exposing (rgb)


-- http://swapi.co/


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
    ( [ { name = "Hoth", diameter = 7200, terrain = Tundra } -- http://swapi.co/api/planets/4/
      , { name = "Tatooine", diameter = 10465, terrain = Desert } -- http://swapi.co/api/planets/1/
      , { name = "Alderaan", diameter = 12500, terrain = Grasslands } -- http://swapi.co/api/planets/2/
      ]
    , Cmd.none
    )



-- MESSAGES


type Msg
    = NoOp



-- VIEW


calculateDrawingSize : Int -> Float
calculateDrawingSize diameter =
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


drawPlanet : Int -> Terrain -> Form Msg
drawPlanet diameter terrain =
    ellipse (calculateDrawingSize diameter) (calculateDrawingSize diameter)
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
                        , (drawPlanet item.diameter item.terrain) |> svg 200 200 310 310
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
