module MeowClient.Project where

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

type Value =
    { id :: Int
    , session :: Session.Value
    }

foreign import apiImpl :: RightF -> LeftF -> Value -> EffPromise (Either Error Json)

api :: Value -> Aff (Either JsonOrJsError Api.Value)
api v = decodeJsErrorOrJson <$> toAffE (apiImpl Right Left v)

foreign import commentsImpl :: RightF -> LeftF -> Int -> Int -> Value -> EffPromise (Either Error Json)

comments :: Int -> Int -> Value -> Aff (Either JsonOrJsError (Array Comment.Value))
comments o l v = decodeJsErrorOrJson <$> toAffE (commentsImpl Right Left o l v)

foreign import commentRepliesImpl :: RightF -> LeftF -> Int -> Int -> Int -> Value -> EffPromise (Either Error Json)

commentReplies :: Int -> Int -> Int -> Value -> Aff (Either JsonOrJsError (Array CommentReply.Value))
commentReplies id o l v = decodeJsErrorOrJson <$> toAffE (commentRepliesImpl Right Left id o l v)

foreign import commentImpl :: RightF -> LeftF -> String -> Int -> Int -> Value -> EffPromise (Either Error Unit)

comment :: String -> Int -> Int -> Value -> Aff (Either Error Unit)
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
