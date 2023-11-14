module MeowClient.Forum
  ( Value
  , createTopic
  , topics
  )
  where

import Prelude

import Data.Argonaut (Json)
import Data.Either (Either(..))
import Effect.Exception (Error)
import Effect.Aff (Aff)
import MeowClient (JsonOrJsError)
import MeowClient.Forum.Topic as Topic
import MeowClient.Session as Session
import MeowClient.Utils (EffPromise, LeftF, RightF, toAffDecodeResult)

type Value =
    { session :: Session.Value
    , id :: Int
    }

foreign import topicsImpl :: RightF -> LeftF -> Int -> Value -> EffPromise (Either Error Json)

topics :: Int -> Value -> Aff (Either JsonOrJsError (Array Topic.Value))
topics p v = toAffDecodeResult $ topicsImpl Right Left p v

foreign import createTopicImpl :: RightF -> LeftF -> String -> String -> Value -> EffPromise (Either Error Json)

createTopic :: String -> String -> Value -> Aff (Either JsonOrJsError Unit)
createTopic t b v = toAffDecodeResult $ createTopicImpl Right Left t b v
