module MeowClient.ForumPost
  ( Value
  , edit
  , info
  , source
  )
  where

import Prelude

import Data.Either (Either(..))
import Effect.Aff (Aff)
import Effect.Exception (Error)
import MeowClient.ForumPost.Info as Info
import MeowClient.JsonOrJsError as JsonOrJsError
import MeowClient.Session as Session
import MeowClient.Utils (EffPromise, LeftF, RightF)
import Promise.Aff (toAffE)

type JsonOrJsError = JsonOrJsError.Value

type Value =
    { session :: Session.Value
    , id :: Int
    }

foreign import infoImpl :: RightF -> LeftF -> Value -> EffPromise (Either Error Info.Value)

info :: Value -> Aff (Either Error Info.Value)
info v = toAffE $ infoImpl Right Left v

foreign import sourceImpl :: RightF -> LeftF -> Value -> EffPromise (Either Error String)

source :: Value -> Aff (Either Error String)
source v = toAffE $ sourceImpl Right Left v

foreign import editImpl :: RightF -> LeftF -> String -> Value -> EffPromise (Either Error String)

edit :: String -> Value -> Aff (Either Error String)
edit c v = toAffE $ editImpl Right Left c v
