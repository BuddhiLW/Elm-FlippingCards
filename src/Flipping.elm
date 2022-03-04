module Flipping exposing (main)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import List exposing (head, tail)
import String


urlPrefix : String
urlPrefix =
    "img/"


view : Model -> Html Msg
view model =
    div [ class "tarot" ]
        [ div [ id "counter" ]
            [ text "Counter: "
            , span [] [ text "0" ]
            , text " seconds"
            ]
        , h1 [ class "center" ] [ text "TAROT CARD GAME" ]
        , let
            -- Stantiate two intances of cards: https://discourse.elm-lang.org/t/sequential-function-calls/8205/2
            cardViews1 =
                List.map (initializeCards 1 model.selectedCards model.activeCard) model.cards

            cardViews2 =
                List.map (initializeCards 10 model.selectedCards model.activeCard) model.cards
          in
          Html.ul []
            (List.concat [ cardViews1, cardViews2 ])
        ]


anyCardIn card list =
    List.any (\cardIn -> card == cardIn) list


initializeCards n selectedCards activeCard card =
    let
        strId =
            String.fromInt (n * card.card)

        strCardId =
            String.concat [ "card", String.fromInt (n * card.card) ]
    in
    li
        [ id strCardId
        , classList [ ( "active", activeCard == strCardId ) ]
        , classList [ ( "active", anyCardIn strCardId selectedCards ) ]
        , onClick (ClickedCard { url = card.url, id = strCardId })
        ]
        []


type alias Card =
    { url : String
    , card : Int
    , selected : Bool
    }


type alias Model =
    { cards : List Card
    , selectedCards : List String
    , activeCard : String
    }



-- type Selection
--     = None
--     | One
--     | IncorrectPair
--     | CorrectPair


initialModel : Model
initialModel =
    { cards =
        [ { url = "Gita.jpg", card = 1, selected = False }
        , { url = "Kali.jpg", card = 2, selected = False }
        , { url = "Arjuna.jpg", card = 3, selected = False }
        , { url = "Krishna.jpg", card = 4, selected = False }
        , { url = "Manjusri.jpg", card = 5, selected = False }
        , { url = "siddartha.jpg", card = 6, selected = False }
        , { url = "bodhidharma2.jpg", card = 7, selected = False }
        ]
    , selectedCards = [ "card1" ]
    , activeCard = ""

    -- , seletedUrls = []
    -- , completedPairs = []
    }



-- Helpers for update
-- storeTemporary data selectedCards completedPairs =
--     if (selectedCards.length == 2) && (selectedCards.first == selectedCards.second) then
--         List.append completedPairs selectedCards
--     else if selectedCards.length < 2 then
--         List.append selectedCards [ data ]
--     else
--         List.drop 2 selectedCards
-- setSelected : String -> Msg -> Msg
-- setSelectedUrl url model =
--     { model | selectedCard = url }


type Msg
    = ClickedCard { url : String, id : String }
    | Other


update : Msg -> Model -> Model
update msg model =
    case msg of
        ClickedCard data ->
            { model | activeCard = data.id }

        _ ->
            model


main =
    Browser.sandbox
        { init = initialModel
        , view = view
        , update = update
        }
