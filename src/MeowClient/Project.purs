module MeowClient.Project
  ( Comment
  , CommentReply
  , Pointer
  , api
  , commentReplies
  , comments
  , favorite
  , isFavoriting
  , isLoving
  , love
  , sendComment
  , sendComment'
  , setCommenting
  , setFavoriting
  , setInstructions
  , setLoving
  , setNotesAndCredits
  , setThumbnail
  , setTitle
  , share
  , unfavorite
  , unlove
  , unshare
  )
  where

import Prelude

import Data.Argonaut (Json)
import Data.Either (Either(..))
import Effect.Aff (Aff)
import Effect.Exception (Error)
import MeowClient.JsonOrJsError as JsonOrJsError
import MeowClient.Project.Api as Api
import MeowClient.Project.Comment as Comment
import MeowClient.Project.Comment.Reply as CommentReply
import MeowClient.Session as Session
import MeowClient.Utils (LeftF, RightF, EffPromise, decodeJsErrorOrJson)
import Node.Buffer (Buffer)
import Promise.Aff (toAffE)

type Comment = Comment.Value
type CommentReply = CommentReply.Value

-- | Project pointer.
-- | ### Example
-- | ```purescript
-- | do
-- |    let project = { id : 874061786, session }
-- |    result <- api project
-- | ```
type Pointer =
    { id :: Int
    , session :: Session.Value
    }

foreign import apiImpl :: RightF -> LeftF -> Pointer -> EffPromise (Either Error Json)

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
api :: Pointer -> Aff (Either JsonOrJsError.Value Api.Value)
api v = decodeJsErrorOrJson <$> toAffE (apiImpl Right Left v)

foreign import commentsImpl :: RightF -> LeftF -> Int -> Int -> Pointer -> EffPromise (Either Error Json)

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
comments :: Int -> Int -> Pointer -> Aff (Either JsonOrJsError.Value (Array Comment.Value))
comments offset limit v = decodeJsErrorOrJson <$> toAffE (commentsImpl Right Left offset limit v)

foreign import commentRepliesImpl :: RightF -> LeftF -> Int -> Int -> Int -> Pointer -> EffPromise (Either Error Json)

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
commentReplies :: Int -> Int -> Int -> Pointer -> Aff (Either JsonOrJsError.Value (Array CommentReply.Value))
commentReplies offset limit id v = decodeJsErrorOrJson <$> toAffE (commentRepliesImpl Right Left offset limit id v)

foreign import sendCommentImpl :: RightF -> LeftF -> Int -> Int -> String -> Pointer -> EffPromise (Either Error Unit)

-- | Leaves a comment on a project.
-- | 
-- | `sendComment [commentee id] [parent id] [content] [project]`
-- | ### Example
-- | ```purescript
-- | do
-- |    result <- sendComment 0 0 "Hello!" project
-- |    case result of
-- |        Left error -> -- ...
-- |        Right _ -> -- ...
-- | ```
sendComment :: Int -> Int -> String -> Pointer -> Aff (Either Error Unit)
sendComment commenteeId parentId content v = toAffE $ sendCommentImpl Right Left commenteeId parentId content v

-- | Alias for `sendComment 0 0`.
sendComment' :: String -> Pointer -> Aff (Either Error Unit)
sendComment' = sendComment 0 0

foreign import setCommentingImpl :: RightF -> LeftF -> Boolean -> Pointer -> EffPromise (Either Error Unit)

-- | Sets commenting of a project (open or closed).
-- | 
-- | `setCommenting [is open?] [project]`
-- | ### Example
-- | ```purescript
-- | do
-- |    result <- setCommenting false project
-- |    case result of
-- |        Left error -> -- ...
-- |        Right _ -> -- ...
-- | ```
setCommenting :: Boolean -> Pointer -> Aff (Either Error Unit)
setCommenting isOpen v = toAffE $ setCommentingImpl Right Left isOpen v

foreign import setTitleImpl :: RightF -> LeftF -> String -> Pointer -> EffPromise (Either Error Unit)

-- | Sets title of a project.
-- | 
-- | `setTitle [content] [project]`
-- | ### Example
-- | ```purescript
-- | do
-- |    result <- setTitle "New title!" project
-- |    case result of
-- |        Left error -> -- ...
-- |        Right _ -> -- ...
-- | ```
setTitle :: String -> Pointer -> Aff (Either Error Unit)
setTitle content v = toAffE $ setTitleImpl Right Left content v

foreign import setInstructionsImpl :: RightF -> LeftF -> String -> Pointer -> EffPromise (Either Error Unit)

-- | Sets instructions of a project.
-- | 
-- | `setInstructions [content] [project]`
-- | ### Example
-- | ```purescript
-- | do
-- |    result <- setInstructions "Use WASD to move!" project
-- |    case result of
-- |        Left error -> -- ...
-- |        Right _ -> -- ...
-- | ```
setInstructions :: String -> Pointer -> Aff (Either Error Unit)
setInstructions content v = toAffE $ setInstructionsImpl Right Left content v

foreign import setNotesAndCreditsImpl :: RightF -> LeftF -> String -> Pointer -> EffPromise (Either Error Unit)

-- | Sets "Notes and Credits" of a project.
-- | 
-- | `setNotesAndCredits [content] [project]`
-- | ### Example
-- | ```purescript
-- | do
-- |    result <- setNotesAndCredits "Thanks to everyone!" project
-- |    case result of
-- |        Left error -> -- ...
-- |        Right _ -> -- ...
-- | ```
setNotesAndCredits :: String -> Pointer -> Aff (Either Error Unit)
setNotesAndCredits content v = toAffE $ setNotesAndCreditsImpl Right Left content v

foreign import setThumbnailImpl :: RightF -> LeftF -> Buffer -> Pointer -> EffPromise (Either Error Unit)

-- | Sets thumbnail of a project.
-- |
-- | `setThumbnail [buffer] [project]`
-- | ### Example
-- | ```purescript
-- | do
-- |    result <- setThumbnail buffer project
-- |    case result of
-- |        Left error -> -- ...
-- |        Right _ -> -- ...
-- | ```
setThumbnail :: Buffer -> Pointer -> Aff (Either Error Unit)
setThumbnail buffer v = toAffE $ setThumbnailImpl Right Left buffer v

foreign import shareImpl :: RightF -> LeftF -> Pointer -> EffPromise (Either Error Unit)

-- | Shares a project.
-- |
-- | `share [project]`
-- | ### Example
-- | ```purescript
-- | do
-- |    result <- share project
-- |    case result of
-- |        Left error -> -- ...
-- |        Right _ -> -- ...
-- | ```
share :: Pointer -> Aff (Either Error Unit)
share v = toAffE $ shareImpl Right Left v

foreign import unshareImpl :: RightF -> LeftF -> Pointer -> EffPromise (Either Error Unit)

-- | Unshares a project.
-- |
-- | `unshare [project]`
-- | ### Example
-- | ```purescript
-- | do
-- |    result <- unshare project
-- |    case result of
-- |        Left error -> -- ...
-- |        Right _ -> -- ...
-- | ```
unshare :: Pointer -> Aff (Either Error Unit)
unshare v = toAffE $ unshareImpl Right Left v

foreign import isLovingImpl :: RightF -> LeftF -> Pointer -> EffPromise (Either Error Json)

-- | Checks whether logged in user is loving a project.
-- |
-- | `isLoving [project]`
-- | ### Example
-- | ```purescript
-- | do
-- |    result <- isLoving project
-- |    case result of
-- |        Left error -> -- ...
-- |        Right isLoving' -> -- ...
-- | ```
isLoving :: Pointer -> Aff (Either JsonOrJsError.Value Boolean)
isLoving v = decodeJsErrorOrJson <$> toAffE (isLovingImpl Right Left v)

foreign import isFavoritingImpl :: RightF -> LeftF -> Pointer -> EffPromise (Either Error Json)

-- | Checks whether logged in user is favoriting a project.
-- |
-- | `isFavoriting [project]`
-- | ### Example
-- | ```purescript
-- | do
-- |    result <- isFavoriting project
-- |    case result of
-- |        Left error -> -- ...
-- |        Right isFavoriting' -> -- ...
-- | ```
isFavoriting :: Pointer -> Aff (Either JsonOrJsError.Value Boolean)
isFavoriting v = decodeJsErrorOrJson <$> toAffE (isFavoritingImpl Right Left v)

foreign import setLovingImpl :: RightF -> LeftF -> Boolean -> Pointer -> EffPromise (Either Error Unit)

-- | Loves/unloves a project.
-- |
-- | `setLoving [is loving?] [project]`
-- | ### Example
-- | ```purescript
-- | do
-- |    result <- setLoving true project
-- |    case result of
-- |        Left error -> -- ...
-- |        Right _ -> -- ...
-- | ```
setLoving :: Boolean -> Pointer -> Aff (Either Error Unit)
setLoving state v = toAffE $ setLovingImpl Right Left state v

foreign import setFavoritingImpl :: RightF -> LeftF -> Boolean -> Pointer -> EffPromise (Either Error Unit)

-- | Favorites/unfavorites a project.
-- |
-- | `setFavoriting [is favoriting?] [project]`
-- | ### Example
-- | ```purescript
-- | do
-- |    result <- setFavoriting true project
-- |    case result of
-- |        Left error -> -- ...
-- |        Right _ -> -- ...
-- | ```
setFavoriting :: Boolean -> Pointer -> Aff (Either Error Unit)
setFavoriting state v = toAffE $ setFavoritingImpl Right Left state v

-- | Alias for `setLoving true`.
love :: Pointer -> Aff (Either Error Unit)
love = setLoving true

-- | Alias for `setLoving false`.
unlove :: Pointer -> Aff (Either Error Unit)
unlove = setLoving false

-- | Alias for `setFavoriting true`.
favorite :: Pointer -> Aff (Either Error Unit)
favorite = setFavoriting true

-- | Alias for `setFavoriting false`.
unfavorite :: Pointer -> Aff (Either Error Unit)
unfavorite = setFavoriting false
