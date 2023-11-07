module MeowClient.Profile where

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

type Value =
    { username :: String
    , session :: Session.Value
    }

foreign import statusImpl :: RightF -> LeftF -> Value -> Effect (Promise (Either Error Json))

status :: Value -> Aff (Either JsonOrJsError Status.Value)
status v = decodeJsErrorOrJson <$> (toAffE $ statusImpl Right Left v)

foreign import followImpl :: RightF -> LeftF -> Value -> Effect (Promise (Either Error Unit))

follow :: Value -> Aff (Either Error Unit)
follow v = toAffE $ followImpl Right Left v

foreign import unfollowImpl :: RightF -> LeftF -> Value -> Effect (Promise (Either Error Unit))

unfollow :: Value -> Aff (Either Error Unit)
unfollow v = toAffE $ unfollowImpl Right Left v

foreign import commentImpl :: RightF -> LeftF -> String -> Int -> Int -> Value -> Effect (Promise (Either Error Unit))

comment :: String -> Int -> Int -> Value -> Aff (Either Error Unit)
comment c pid cid v = toAffE $ commentImpl Right Left c pid cid v

foreign import deleteCommentImpl :: RightF -> LeftF -> Int -> Value -> Effect (Promise (Either Error Unit))

deleteComment :: Int -> Value -> Aff (Either Error Unit)
deleteComment id v = toAffE $ deleteCommentImpl Right Left id v

foreign import apiImpl :: RightF -> LeftF -> Value -> Effect (Promise (Either Error Json))

api :: Value -> Aff (Either JsonOrJsError Api.Value)
api v = decodeJsErrorOrJson <$> toAffE (apiImpl Right Left v)

foreign import messagesCountImpl :: RightF -> LeftF -> Value -> Effect (Promise (Either Error Json))

messagesCount :: Value -> Aff (Either JsonOrJsError Int)
messagesCount v = decodeJsErrorOrJson <$> toAffE (messagesCountImpl Right Left v)

foreign import commentsImpl :: RightF -> LeftF -> Int -> Value -> Effect (Promise (Either Error Json))

comments :: Int -> Value -> Aff (Either JsonOrJsError (Array Comment.Value))
comments p v = decodeJsErrorOrJson <$> toAffE (commentsImpl Right Left p v)

foreign import toggleCommentsImpl :: RightF -> LeftF -> Value -> Effect (Promise (Either Error Unit))

toggleComments :: Value -> Aff (Either Error Unit)
toggleComments v = toAffE $ toggleCommentsImpl Right Left v
