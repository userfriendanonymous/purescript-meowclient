module MeowClient.Forum where

import Prelude

import Data.Argonaut (Json)
import Data.Either (Either(..))
import Effect.Exception (Error)
import Effect.Aff (Aff)
import MeowClient (JsonOrJsError)
import MeowClient.Forum.Topic as Topic
import MeowClient.Session as Session
import MeowClient.Utils (EffPromise, LeftF, RightF, toAffDecodeResult)

type Session = Session.Value

type Value =
    { session :: Session
    , id :: Int
    }

foreign import topicsImpl :: RightF -> LeftF -> Int -> Value -> EffPromise (Either Error Json)

topics :: Int -> Value -> Aff (Either JsonOrJsError (Array Topic.Value))
topics p v = toAffDecodeResult $ topicsImpl Right Left p v

foreign import createTopicImpl :: RightF -> LeftF -> String -> String -> Value -> EffPromise (Either Error Json)

createTopic :: String -> String -> Value -> Aff (Either JsonOrJsError Unit)
createTopic t b v = toAffDecodeResult $ createTopicImpl Right Left t b v

foreign import setSignatureImpl :: RightF -> LeftF -> String -> Value -> EffPromise (Either Error Json)

setSignature :: String -> Value -> Aff (Either JsonOrJsError Unit)
setSignature c v = toAffDecodeResult $ setSignatureImpl Right Left c v
