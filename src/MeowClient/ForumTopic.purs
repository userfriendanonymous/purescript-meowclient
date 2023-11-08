module MeowClient.ForumTopic where

import Prelude

import Data.Argonaut (Json)
import Data.Either (Either(..))
import Effect.Aff (Aff)
import Effect.Exception (Error)
import MeowClient.ForumPost (JsonOrJsError)
import MeowClient.ForumTopic.Info as Info
import MeowClient.Session as Session
import MeowClient.Utils (EffPromise, LeftF, RightF, toAffDecodeResult)

type Session = Session.Value

type Value =
    { session :: Session
    , id :: Int
    }

foreign import infoImpl :: RightF -> LeftF -> Value -> EffPromise (Either Error Json)

info :: Value -> Aff (Either JsonOrJsError Info.Value)
info v = toAffDecodeResult $ infoImpl Right Left v