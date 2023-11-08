module MeowClient.ForumPost.Info where

import Prelude

import Data.Argonaut (class DecodeJson, Json, JsonDecodeError, decodeJson, getField)
import Data.Argonaut.Decode.Decoders (decodeJObject)
import Data.Either (Either)
import Data.JSDate (JSDate)

type Value =
    { content :: String
    , parsableContent :: Void
    , author :: String
    , date :: JSDate
    }
