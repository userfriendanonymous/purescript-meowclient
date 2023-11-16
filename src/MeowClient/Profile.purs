module MeowClient.Profile
  ( Value
  , api
  , comment
  , comments
  , deleteComment
  , follow
  , messagesCount
  , status
  , toggleCommenting
  , unfollow
  )
  where

import Prelude

import Data.Argonaut (Json)
import Data.Either (Either(..))
import Effect (Effect)
import Effect.Aff (Aff)
import Effect.Exception (Error)
import MeowClient (JsonOrJsError)
import MeowClient.Profile.Api as Api
import MeowClient.Profile.Comment as Comment
import MeowClient.Profile.Status as Status
import MeowClient.Session as Session
import MeowClient.Utils (LeftF, RightF, decodeJsErrorOrJson)
import Promise (Promise)
import Promise.Aff (toAffE)

-- | Profile pointer.
-- |
-- | ### Example
type Value =
    { username :: String
    , session :: Session.Value
    }

foreign import statusImpl :: RightF -> LeftF -> Value -> Effect (Promise (Either Error Json))

-- | Gets profile status (scratcher / new scratcher / scratch team).
-- | 
-- | `status [profile]`
-- | ### Example
-- | ```purescript
-- | do
-- |    result <- status profile
-- |    case result of
-- |        Left error -> -- ...
-- |        Right status -> -- ...
-- | ```
status :: Value -> Aff (Either JsonOrJsError Status.Value)
status v = decodeJsErrorOrJson <$> (toAffE $ statusImpl Right Left v)

foreign import followImpl :: RightF -> LeftF -> Value -> Effect (Promise (Either Error Unit))

-- | Follow a user.
-- | 
-- | `follow [profile]`
-- | ### Example
-- | ```purescript
-- | do
-- |    result <- follow profile
-- |    case result of
-- |        Left error -> -- ...
-- |        Right _ -> -- ...
-- | ```
follow :: Value -> Aff (Either Error Unit)
follow v = toAffE $ followImpl Right Left v

foreign import unfollowImpl :: RightF -> LeftF -> Value -> Effect (Promise (Either Error Unit))

-- | Unfollows a user.
-- | 
-- | `unfollow [profile]`
-- | ### Example
-- | ```purescript
-- | do
-- |    result <- unfollow profile
-- |    case result of
-- |        Left error -> -- ...
-- |        Right _ -> -- ...
-- | ```
unfollow :: Value -> Aff (Either Error Unit)
unfollow v = toAffE $ unfollowImpl Right Left v

foreign import commentImpl :: RightF -> LeftF -> Int -> Int -> String -> Value -> Effect (Promise (Either Error Unit))

-- | Leaves a comment on a profile.
-- | 
-- | `comment [commentee id] [parent id] [content] [profile]`
-- | ### Example
-- | ```purescript
-- | do
-- |    result <- comment 0 0 "Hello!" profile
-- |    case result of
-- |        Left error -> -- ...
-- |        Right _ -> -- ...
-- | ```
comment :: Int -> Int -> String -> Value -> Aff (Either Error Unit)
comment commenteeId parentId content v = toAffE $ commentImpl Right Left commenteeId parentId content v

foreign import deleteCommentImpl :: RightF -> LeftF -> Int -> Value -> Effect (Promise (Either Error Unit))

-- | Deletes a comment on a profile.
-- | 
-- | `deleteComment [comment id] [profile]`
-- | ### Example
-- | ```purescript
-- | do
-- |    result <- deleteComment 104027540 profile
-- |    case result of
-- |        Left error -> -- ...
-- |        Right _ -> -- ...
-- | ```
deleteComment :: Int -> Value -> Aff (Either Error Unit)
deleteComment id v = toAffE $ deleteCommentImpl Right Left id v

foreign import apiImpl :: RightF -> LeftF -> Value -> Effect (Promise (Either Error Json))

-- | Gets api information of a profile.
-- | 
-- | `api [profile]`
-- | ### Example
-- | ```purescript
-- | do
-- |    result <- api profile
-- |    case result of
-- |        Left error -> -- ...
-- |        Right info -> -- ...
-- | ```
api :: Value -> Aff (Either JsonOrJsError Api.Value)
api v = decodeJsErrorOrJson <$> toAffE (apiImpl Right Left v)

foreign import messagesCountImpl :: RightF -> LeftF -> Value -> Effect (Promise (Either Error Json))

-- | Gets messages' count of a user.
-- | 
-- | `messagesCount [profile]`
-- | ### Example
-- | ```purescript
-- | do
-- |    result <- messagesCount profile
-- |    case result of
-- |        Left error -> -- ...
-- |        Right count -> -- ...
-- | ```
messagesCount :: Value -> Aff (Either JsonOrJsError Int)
messagesCount v = decodeJsErrorOrJson <$> toAffE (messagesCountImpl Right Left v)

foreign import commentsImpl :: RightF -> LeftF -> Int -> Value -> Effect (Promise (Either Error Json))

-- | Gets comments on a profile.
-- | 
-- | `comments [page] [profile]`
-- | ### Example
-- | ```purescript
-- | do
-- |    result <- comments 1
-- |    case result of
-- |        Left error -> -- ...
-- |        Right comments' -> -- ...
-- | ```
comments :: Int -> Value -> Aff (Either JsonOrJsError (Array Comment.Value))
comments page v = decodeJsErrorOrJson <$> toAffE (commentsImpl Right Left page v)

foreign import toggleCommentingImpl :: RightF -> LeftF -> Value -> Effect (Promise (Either Error Unit))

-- | Toggles profile commenting.
-- | 
-- | `toggleCommenting [profile]`
-- | ### Example
-- | ```purescript
-- | do
-- |    result <- toggleCommenting profile
-- |    case result of
-- |        Left error -> -- ...
-- |        Right _ -> -- ...
-- | ```
toggleCommenting :: Value -> Aff (Either Error Unit)
toggleCommenting v = toAffE $ toggleCommentingImpl Right Left v
