module MeowClient.ForumTopic
  ( Value
  , follow
  , info
  , posts
  , reply
  , unfollow
  )
  where

import Prelude

import Data.Argonaut (Json)
import Data.Either (Either(..))
import Data.Tuple (Tuple(..))
import Effect.Aff (Aff)
import Effect.Exception (Error)
import MeowClient.ForumPost.Info as PostInfo
import MeowClient.ForumTopic.Info as Info
import MeowClient.Session as Session
import MeowClient.JsonOrJsError as JsonOrJsError
import MeowClient.Utils (EffPromise, LeftF, RightF, TupleF, toAffDecodeResult)
import Promise.Aff (toAffE)

type Value =
    { session :: Session.Value
    , id :: Int
    }

foreign import infoImpl :: RightF -> LeftF -> Value -> EffPromise (Either Error Json)

info :: Value -> Aff (Either JsonOrJsError.Value Info.Value)
info v = toAffDecodeResult $ infoImpl Right Left v

foreign import postsImpl :: RightF -> LeftF -> TupleF -> Value -> EffPromise (Either Error (Array (Tuple Int PostInfo.Value)))

posts :: Value -> Aff (Either Error (Array (Tuple Int PostInfo.Value)))
posts v = toAffE $ postsImpl Right Left Tuple v

foreign import replyImpl :: RightF -> LeftF -> String -> Value -> EffPromise (Either Error Json)

reply :: String -> Value -> Aff (Either JsonOrJsError.Value Unit)
reply c v = toAffDecodeResult $ replyImpl Right Left c v

foreign import followImpl :: RightF -> LeftF -> Value -> EffPromise (Either Error Json)

follow :: Value -> Aff (Either JsonOrJsError.Value Unit)
follow v = toAffDecodeResult $ followImpl Right Left v

foreign import unfollowImpl :: RightF -> LeftF -> Value -> EffPromise (Either Error Json)

unfollow :: Value -> Aff (Either JsonOrJsError.Value Unit)
unfollow v = toAffDecodeResult $ unfollowImpl Right Left v
