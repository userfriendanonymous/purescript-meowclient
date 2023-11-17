module MeowClient.SearchMode where

import Prelude

import Data.Argonaut (class DecodeJson, class EncodeJson, JsonDecodeError(..), decodeJson, encodeJson)
import Data.Either (Either(..))

data Value = Popular | Trending

instance EncodeJson Value where
    encodeJson = case _ of
        Popular -> encodeJson "popular"
        Trending -> encodeJson "trending"

instance DecodeJson Value where
    decodeJson j = do
        str <- decodeJson j
        case str of
            "popular" -> Right Popular
            "trending" -> Right Trending
            _ -> Left $ TypeMismatch "invalid value"
            