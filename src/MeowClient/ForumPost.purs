module MeowClient.ForumPost
  ( Info
  , Pointer
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

type Info = Info.Value
type JsonOrJsError = JsonOrJsError.Value

-- | Forum post pointer.
-- | ### Example
-- | ```purescript
-- | do
-- |    let forumPost = { id : 415011012, session }
-- |    result <- info forumPost
-- | ```
type Pointer =
    { session :: Session.Value
    , id :: Int
    }

foreign import infoImpl :: RightF -> LeftF -> Pointer -> EffPromise (Either Error Info.Value)

-- | Gets information about a forum post.
-- | 
-- | `info [forum post]`
-- | ### Example
-- | ```purescript
-- | do
-- |    result <- info forumPost
-- |    case result of
-- |        Left error -> -- ...
-- |        Right info' -> -- ...
-- | ```
info :: Pointer -> Aff (Either Error Info.Value)
info v = toAffE $ infoImpl Right Left v

foreign import sourceImpl :: RightF -> LeftF -> Pointer -> EffPromise (Either Error String)

-- | Gets source of a forum post.
-- | 
-- | `source [forum post]`
-- | ### Example
-- | ```purescript
-- | do
-- |    result <- source forumPost
-- |    case result of
-- |        Left error -> -- ...
-- |        Right source' -> -- ...
-- | ```
source :: Pointer -> Aff (Either Error String)
source v = toAffE $ sourceImpl Right Left v

foreign import editImpl :: RightF -> LeftF -> String -> Pointer -> EffPromise (Either Error Unit)

-- | Edits a forum post.
-- | 
-- | `edit [new content] [forum post]`
-- | ### Example
-- | ```purescript
-- | do
-- |    result <- edit "Edited!" forumPost
-- |    case result of
-- |        Left error -> -- ...
-- |        Right _ -> -- ...
-- | ```
edit :: String -> Pointer -> Aff (Either Error Unit)
edit content v = toAffE $ editImpl Right Left content v
