module MeowClient.Project
  ( Value
  , api
  , comment
  , commentReplies
  , comments
  , isFavoriting
  , isLoving
  , setCommenting
  , setFavoriting
  , setInstructions
  , setLoving
  , setNotesAndCredits
  , setThumbnail
  , setTitle
  , share
  , unshare
  )
  where

import Prelude

import Data.Argonaut (Json)
import Data.Either (Either(..))
import Effect.Aff (Aff)
import Effect.Exception (Error)
import MeowClient (JsonOrJsError)
import MeowClient.Project.Comment as Comment
import MeowClient.Project.Comment.Reply as CommentReply
import MeowClient.Project.Api as Api
import MeowClient.Session as Session
import MeowClient.Utils (LeftF, RightF, EffPromise, decodeJsErrorOrJson)
import Node.Buffer (Buffer)
import Promise.Aff (toAffE)

-- | Project pointer.
-- | ### Example
-- | ```purescript
-- | do
-- |    let project = { id : 874061786, session }
-- |    result <- api project
-- | ```
type Value =
    { id :: Int
    , session :: Session.Value
    }

foreign import apiImpl :: RightF -> LeftF -> Value -> EffPromise (Either Error Json)

-- | Gets api information for a project.
-- | 
-- | `api [project]`
-- | ### Example
-- | ```purescript
-- | do
-- |    result <- api project
-- |    case result of
-- |        Left error -> -- ...
-- |        Right info -> -- ...
-- | ```
api :: Value -> Aff (Either JsonOrJsError Api.Value)
api v = decodeJsErrorOrJson <$> toAffE (apiImpl Right Left v)

foreign import commentsImpl :: RightF -> LeftF -> Int -> Int -> Value -> EffPromise (Either Error Json)

-- | Gets comments of a project.
-- | 
-- | `comments [offset] [limit] [project]`
-- | ### Example
-- | ```purescript
-- | do
-- |    result <- comments 0 20 project
-- |    case result of
-- |        Left error -> -- ...
-- |        Right arrayOfComments -> -- ...
-- | ```
comments :: Int -> Int -> Value -> Aff (Either JsonOrJsError (Array Comment.Value))
comments offset limit v = decodeJsErrorOrJson <$> toAffE (commentsImpl Right Left offset limit v)

foreign import commentRepliesImpl :: RightF -> LeftF -> Int -> Int -> Int -> Value -> EffPromise (Either Error Json)

-- | Gets replies of a comment in a project.
-- | 
-- | `commentReplies [offset] [limit] [comment id] [project]`
-- | ### Example
-- | ```purescript
-- | do
-- |    result <- commentReplies 0 20 43409410
-- |    case result of
-- |        Left error -> -- ...
-- |        Right replies -> -- ...
-- | ```
commentReplies :: Int -> Int -> Int -> Value -> Aff (Either JsonOrJsError (Array CommentReply.Value))
commentReplies offset limit id v = decodeJsErrorOrJson <$> toAffE (commentRepliesImpl Right Left offset limit id v)

foreign import commentImpl :: RightF -> LeftF -> Int -> Int -> String -> Value -> EffPromise (Either Error Unit)

-- | Leaves a comment.
-- | 
-- | `comment [commentee id] [parent id] [content] [project]`
-- | ### Example
-- | ```purescript
-- | do
-- |    result <- comment 0 0 "Hello!" project
-- |    case result of
-- |        Left error -> -- ...
-- |        Right _ -> -- ...
-- | ```
comment :: Int -> Int -> String -> Value -> Aff (Either Error Unit)
comment c pi ci v = toAffE $ commentImpl Right Left c pi ci v

foreign import setCommentingImpl :: RightF -> LeftF -> Boolean -> Value -> EffPromise (Either Error Unit)

setCommenting :: Boolean -> Value -> Aff (Either Error Unit)
setCommenting a v = toAffE $ setCommentingImpl Right Left a v

foreign import setTitleImpl :: RightF -> LeftF -> String -> Value -> EffPromise (Either Error Unit)

setTitle :: String -> Value -> Aff (Either Error Unit)
setTitle a v = toAffE $ setTitleImpl Right Left a v

foreign import setInstructionsImpl :: RightF -> LeftF -> String -> Value -> EffPromise (Either Error Unit)

setInstructions :: String -> Value -> Aff (Either Error Unit)
setInstructions a v = toAffE $ setInstructionsImpl Right Left a v

foreign import setNotesAndCreditsImpl :: RightF -> LeftF -> String -> Value -> EffPromise (Either Error Unit)

setNotesAndCredits :: String -> Value -> Aff (Either Error Unit)
setNotesAndCredits a v = toAffE $ setNotesAndCreditsImpl Right Left a v

foreign import setThumbnailImpl :: RightF -> LeftF -> Buffer -> Value -> EffPromise (Either Error Unit)

setThumbnail :: Buffer -> Value -> Aff (Either Error Unit)
setThumbnail a v = toAffE $ setThumbnailImpl Right Left a v

foreign import shareImpl :: RightF -> LeftF -> Value -> EffPromise (Either Error Unit)

share :: Value -> Aff (Either Error Unit)
share v = toAffE $ shareImpl Right Left v

foreign import unshareImpl :: RightF -> LeftF -> Value -> EffPromise (Either Error Unit)

unshare :: Value -> Aff (Either Error Unit)
unshare v = toAffE $ unshareImpl Right Left v

foreign import isLovingImpl :: RightF -> LeftF -> Value -> EffPromise (Either Error Json)

isLoving :: Value -> Aff (Either JsonOrJsError Boolean)
isLoving v = decodeJsErrorOrJson <$> toAffE (isLovingImpl Right Left v)

foreign import isFavoritingImpl :: RightF -> LeftF -> Value -> EffPromise (Either Error Json)

isFavoriting :: Value -> Aff (Either JsonOrJsError Boolean)
isFavoriting v = decodeJsErrorOrJson <$> toAffE (isFavoritingImpl Right Left v)

foreign import setLovingImpl :: RightF -> LeftF -> Boolean -> Value -> EffPromise (Either Error Unit)

setLoving :: Boolean -> Value -> Aff (Either Error Unit)
setLoving i v = toAffE $ setLovingImpl Right Left i v

foreign import setFavoritingImpl :: RightF -> LeftF -> Boolean -> Value -> EffPromise (Either Error Unit)

setFavoriting :: Boolean -> Value -> Aff (Either Error Unit)
setFavoriting i v = toAffE $ setFavoritingImpl Right Left i v
