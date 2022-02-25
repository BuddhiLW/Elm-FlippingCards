module PhotoGroove exposing (main)

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
        , ul [] (List.map (initializeCards model.selectedUrl) model.photos)
        ]


initializeCards selectedUrl photo =
    li
        [ id (String.concat [ "card", String.fromInt photo.card ])
        , classList [ ( "active", selectedUrl == photo.url ) ]
        , onClick { description = "ClickedPhoto", data = photo.url }
        ]
        []



-- activateCard =


initialModel =
    { photos =
        [ { url = "Gita.jpg", card = 0 }
        , { url = "Kali.jpg", card = 1 }
        , { url = "Arjuna.jpg", card = 2 }
        , { url = "Krishna.jpg", card = 3 }
        , { url = "Manjusri.jpg", card = 4 }
        , { url = "siddartha.jpg", card = 5 }
        , { url = "bodhidharma2.jpg", card = 6 }

        -- , { url = "laughting-buddha-fit-nobg.png", card = 7 }
        ]
    , selectedUrl = ""

    -- , seletedUrls = []
    -- , completedPairs = []
    }



-- Helpers for update
-- storeTemporary data selectedUrls completedPairs =
--     if (selectedUrls.length == 2) && (selectedUrls.first == selectedUrls.second) then
--         List.append completedPairs selectedUrls
--     else if selectedUrls.length < 2 then
--         List.append selectedUrls [ data ]
--     else
--         List.drop 2 selectedUrls


update msg model =
    if msg.description == "ClickedPhoto" then
        { model | selectedUrl = msg.data }

    else
        model


main =
    Browser.sandbox
        { init = initialModel
        , view = view
        , update = update
        }
