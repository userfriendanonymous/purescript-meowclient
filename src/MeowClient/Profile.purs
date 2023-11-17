module MeowClient.Profile
  ( Api
  , Comment
  , Pointer
  , Status
  , api
  , comments
  , deleteComment
  , follow
  , messagesCount
  , sendComment
  , sendComment'
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
import MeowClient.JsonOrJsError as JsonOrJsError
import MeowClient.Profile.Api as Api
import MeowClient.Profile.Comment as Comment
import MeowClient.Profile.Status as Status
import MeowClient.Session as Session
import MeowClient.Utils (LeftF, RightF, decodeJsErrorOrJson)
import Promise (Promise)
import Promise.Aff (toAffE)

type Api = Api.Value
type Comment = Comment.Value
type Status = Status.Value

-- | Profile pointer.
-- | ### Example
-- | ```purescript
-- | do
-- |    let profile = { username : "griffpatch", session }
-- |    result <- api profile
-- | ```
type Pointer =
    { username :: String
    , session :: Session.Value
    }

foreign import statusImpl :: RightF -> LeftF -> Pointer -> Effect (Promise (Either Error Json))

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
status :: Pointer -> Aff (Either JsonOrJsError.Value Status.Value)
status v = decodeJsErrorOrJson <$> (toAffE $ statusImpl Right Left v)

foreign import followImpl :: RightF -> LeftF -> Pointer -> Effect (Promise (Either Error Unit))

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
follow :: Pointer -> Aff (Either Error Unit)
follow v = toAffE $ followImpl Right Left v

foreign import unfollowImpl :: RightF -> LeftF -> Pointer -> Effect (Promise (Either Error Unit))

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
unfollow :: Pointer -> Aff (Either Error Unit)
unfollow v = toAffE $ unfollowImpl Right Left v

foreign import sendCommentImpl :: RightF -> LeftF -> Int -> Int -> String -> Pointer -> Effect (Promise (Either Error Unit))

-- | Leaves a comment on a profile.
-- | 
-- | `sendComment [commentee id] [parent id] [content] [profile]`
-- | ### Example
-- | ```purescript
-- | do
-- |    result <- sendComment 0 0 "Hello!" profile
-- |    case result of
-- |        Left error -> -- ...
-- |        Right _ -> -- ...
-- | ```
sendComment :: Int -> Int -> String -> Pointer -> Aff (Either Error Unit)
sendComment commenteeId parentId content v = toAffE $ sendCommentImpl Right Left commenteeId parentId content v

-- | Alias for `sendComment 0 0`.
sendComment' :: String -> Pointer -> Aff (Either Error Unit)
sendComment' = sendComment 0 0

foreign import deleteCommentImpl :: RightF -> LeftF -> Int -> Pointer -> Effect (Promise (Either Error Unit))

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
deleteComment :: Int -> Pointer -> Aff (Either Error Unit)
deleteComment id v = toAffE $ deleteCommentImpl Right Left id v

foreign import apiImpl :: RightF -> LeftF -> Pointer -> Effect (Promise (Either Error Json))

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
api :: Pointer -> Aff (Either JsonOrJsError.Value Api.Value)
api v = decodeJsErrorOrJson <$> toAffE (apiImpl Right Left v)

foreign import messagesCountImpl :: RightF -> LeftF -> Pointer -> Effect (Promise (Either Error Json))

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
messagesCount :: Pointer -> Aff (Either JsonOrJsError.Value Int)
messagesCount v = decodeJsErrorOrJson <$> toAffE (messagesCountImpl Right Left v)

foreign import commentsImpl :: RightF -> LeftF -> Int -> Pointer -> Effect (Promise (Either Error Json))

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
comments :: Int -> Pointer -> Aff (Either JsonOrJsError.Value (Array Comment.Value))
comments page v = decodeJsErrorOrJson <$> toAffE (commentsImpl Right Left page v)

foreign import toggleCommentingImpl :: RightF -> LeftF -> Pointer -> Effect (Promise (Either Error Unit))

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
toggleCommenting :: Pointer -> Aff (Either Error Unit)
toggleCommenting v = toAffE $ toggleCommentingImpl Right Left v
