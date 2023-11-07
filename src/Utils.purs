module MeowClient.Utils where

import Prelude

import Data.Argonaut (class DecodeJson, Json, decodeJson)
import Data.Either (Either(..))
import Effect.Exception (Error)
import MeowClient (JsonOrJsError)
import MeowClient.JsonOrJsError as JsonOrJsError

type RightF = forall l r . r -> Either l r
type LeftF = forall l r . l -> Either l r

mapLeft :: forall l r l2 . (l -> l2) -> Either l r -> Either l2 r
mapLeft f = case _ of
    Left l -> Left $ f l
    Right r -> Right r

decodeJsErrorOrJson :: forall r . DecodeJson r => Either Error Json -> Either JsonOrJsError r
decodeJsErrorOrJson res = mapLeft JsonOrJsError.Other res >>= mapLeft JsonOrJsError.Json <<< decodeJson
