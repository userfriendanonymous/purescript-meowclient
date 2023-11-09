module MeowClient.Utils where

import Prelude

import Data.Argonaut (class DecodeJson, Json, decodeJson)
import Data.Either (Either(..))
import Data.Tuple (Tuple)
import Effect (Effect)
import Effect.Aff (Aff)
import Effect.Exception (Error)
import MeowClient.JsonOrJsError as JsonOrJsError
import Promise (Promise)
import Promise.Aff (toAffE)

type RightF = forall l r . r -> Either l r
type LeftF = forall l r . l -> Either l r
type TupleF = forall l r . l -> r -> Tuple l r
type EffPromise v = Effect (Promise v)

mapLeft :: forall l r l2 . (l -> l2) -> Either l r -> Either l2 r
mapLeft f = case _ of
    Left l -> Left $ f l
    Right r -> Right r

decodeJsErrorOrJson :: forall r . DecodeJson r => Either Error Json -> Either JsonOrJsError.Value r
decodeJsErrorOrJson res = mapLeft JsonOrJsError.Other res >>= mapLeft JsonOrJsError.Json <<< decodeJson

toAffDecodeResult :: forall r . DecodeJson r => EffPromise (Either Error Json) -> Aff (Either JsonOrJsError.Value r)
toAffDecodeResult v = decodeJsErrorOrJson <$> toAffE v
