module Flipping exposing (main)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import String


urlPrefix =
    "img/"


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
                List.map (initializeCards 1 model.selectedCard) model.cards

            cardViews2 =
                List.map (initializeCards 10 model.selectedCard) model.cards
          in
          Html.ul []
            (List.concat [ cardViews1, cardViews2 ])
        ]


initializeCards n selectedCard card =
    let
        strId =
            String.fromInt (n * card.card)

        strCardId =
            String.concat [ "card", String.fromInt (n * card.card) ]
    in
    li
        [ id strCardId
        , classList [ ( "active", selectedCard == strCardId ) ]
        , onClick { description = "ClickedPhoto", data = { url = card.url, id = strCardId } }
        ]
        []


type alias Card =
    { url : String
    , card : Int
    }


type alias Model =
    { cards : List Card
    , selectedCard : String
    }


type Selection
    = None
    | One
    | IncorrectPair
    | CorrectPair


initialModel =
    { cards =
        [ { url = "Gita.jpg", card = 1 }
        , { url = "Kali.jpg", card = 2 }
        , { url = "Arjuna.jpg", card = 3 }
        , { url = "Krishna.jpg", card = 4 }
        , { url = "Manjusri.jpg", card = 5 }
        , { url = "siddartha.jpg", card = 6 }
        , { url = "bodhidharma2.jpg", card = 7 }

        -- , { url = "laughting-buddha-fit-nobg.png", card = 7 }
        ]
    , selectedCard = "card1"

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


update msg model =
    case msg.description of
        "ClickedPhoto" ->
            { model | selectedCard = msg.data.id }

        _ ->
            model


main =
    Browser.sandbox
        { init = initialModel
        , view = view
        , update = update
        }
