module MeowClient.ForumTopic
  ( Info
  , Pointer
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

type Info = Info.Value

-- | Forum topic pointer.
-- | ### Example
-- | ```purescript
-- | do
-- |    let forumTopic = { id : 305901553, session }
-- |    result <- info forumTopic
-- | ```
type Pointer =
    { session :: Session.Value
    , id :: Int
    }

foreign import infoImpl :: RightF -> LeftF -> Pointer -> EffPromise (Either Error Json)

-- | Gets information about a forum topic.
-- | 
-- | `info [forum topic]`
-- | ### Example
-- | ```purescript
-- | do
-- |    result <- info forumTopic
-- |    case result of
-- |        Left error -> -- ...
-- |        Right info' -> -- ...
-- | ```
info :: Pointer -> Aff (Either JsonOrJsError.Value Info.Value)
info v = toAffDecodeResult $ infoImpl Right Left v

foreign import postsImpl :: RightF -> LeftF -> TupleF -> Int -> Pointer -> EffPromise (Either Error (Array (Tuple Int PostInfo.Value)))

-- | Gets posts of a forum topic.
-- | 
-- | `posts [page] [forum topic]`
-- | ### Example
-- | ```purescript
-- | do
-- |    result <- posts 2 forumTopic
-- |    case result of
-- |        Left error -> -- ...
-- |        Right posts' -> -- ...
-- | ```
posts :: Int -> Pointer -> Aff (Either Error (Array (Tuple Int PostInfo.Value)))
posts page v = toAffE $ postsImpl Right Left Tuple page v

foreign import replyImpl :: RightF -> LeftF -> String -> Pointer -> EffPromise (Either Error Json)

-- | Leaves a reply on a forum topic.
-- | 
-- | `reply [content] [forum topic]`
-- | ### Example
-- | ```purescript
-- | do
-- |    result <- reply "Hello everyone" forumTopic
-- |    case result of
-- |        Left error -> -- ...
-- |        Right _ -> -- ...
-- | ```
reply :: String -> Pointer -> Aff (Either JsonOrJsError.Value Unit)
reply content v = toAffDecodeResult $ replyImpl Right Left content v

foreign import followImpl :: RightF -> LeftF -> Pointer -> EffPromise (Either Error Json)

-- | Follows a forum topic.
-- | 
-- | `follow [forum topic]`
-- | ### Example
-- | ```purescript
-- | do
-- |    result <- follow forumTopic
-- |    case result of
-- |        Left error -> -- ...
-- |        Right _ -> -- ...
-- | ```
follow :: Pointer -> Aff (Either JsonOrJsError.Value Unit)
follow v = toAffDecodeResult $ followImpl Right Left v

foreign import unfollowImpl :: RightF -> LeftF -> Pointer -> EffPromise (Either Error Json)

-- | Unfollows a forum topic.
-- | 
-- | `unfollow [forum topic]`
-- | ### Example
-- | ```purescript
-- | do
-- |    result <- unfollow forumTopic
-- |    case result of
-- |        Left error -> -- ...
-- |        Right _ -> -- ...
-- | ```
unfollow :: Pointer -> Aff (Either JsonOrJsError.Value Unit)
unfollow v = toAffDecodeResult $ unfollowImpl Right Left v
