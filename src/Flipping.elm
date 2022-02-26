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
        , ul [] (List.map (initializeCards model.selectedCard) model.cards)
        ]


initializeCards selectedCard card =
    li
        [ id (String.concat [ "card", String.fromInt card.card ])
        , classList [ ( "active", selectedCard == card.url ) ]
        , onClick { description = "ClickedPhoto", data = card.url }
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
        [ { url = "Gita.jpg", card = 0 }
        , { url = "Kali.jpg", card = 1 }
        , { url = "Arjuna.jpg", card = 2 }
        , { url = "Krishna.jpg", card = 3 }
        , { url = "Manjusri.jpg", card = 4 }
        , { url = "siddartha.jpg", card = 5 }
        , { url = "bodhidharma2.jpg", card = 6 }

        -- , { url = "laughting-buddha-fit-nobg.png", card = 7 }
        ]
    , selectedCard = ""

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


setSelectedUrl url model =
    { model | selectedCard = url }


update msg model =
    case msg.description of
        "ClickedPhoto" ->
            { model | selectedCard = msg.data }

        _ ->
            model


main =
    Browser.sandbox
        { init = initialModel
        , view = view
        , update = update
        }
