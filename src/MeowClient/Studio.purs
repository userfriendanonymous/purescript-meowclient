module MeowClient.Studio where

import Prelude

import Data.Argonaut (Json)
import Data.Either (Either(..))
import Effect.Aff (Aff)
import Effect.Exception (Error)
import MeowClient (JsonOrJsError)
import MeowClient.Profile.Api as ProfileApi
import MeowClient.Session as Session
import MeowClient.Studio.Api as Api
import MeowClient.Studio.MyStatus as MyStatus
import MeowClient.Studio.Project as Project
import MeowClient.Utils (RightF, LeftF, EffPromise, toAffDecodeResult)

type Session = Session.Value

type Value =
    { session :: Session
    , id :: Int
    }

foreign import apiImpl :: RightF -> LeftF -> Value -> EffPromise (Either Error Json)

api :: Value -> Aff (Either JsonOrJsError Api.Value)
api v = toAffDecodeResult $ apiImpl Right Left v

foreign import followImpl :: RightF -> LeftF -> Value -> EffPromise (Either Error Json)

follow :: Value -> Aff (Either JsonOrJsError Unit)
follow v = toAffDecodeResult $ followImpl Right Left v

foreign import unfollowImpl :: RightF -> LeftF -> Value -> EffPromise (Either Error Json)

unfollow :: Value -> Aff (Either JsonOrJsError Unit)
unfollow v = toAffDecodeResult $ followImpl Right Left v

foreign import setTitleImpl :: RightF -> LeftF -> String -> Value -> EffPromise (Either Error Json)

setTitle :: String -> Value -> Aff (Either JsonOrJsError Unit)
setTitle s v = toAffDecodeResult $ setTitleImpl Right Left s v

foreign import setDescriptionImpl :: RightF -> LeftF -> String -> Value -> EffPromise (Either Error Json)

setDescription :: String -> Value -> Aff (Either JsonOrJsError Unit)
setDescription s v = toAffDecodeResult $ setDescriptionImpl Right Left s v

foreign import inviteCuratorImpl :: RightF -> LeftF -> String -> Value -> EffPromise (Either Error Json)

inviteCurator :: String -> Value -> Aff (Either JsonOrJsError Unit)
inviteCurator s v = toAffDecodeResult $ inviteCuratorImpl Right Left s v

foreign import removeCuratorImpl :: RightF -> LeftF -> String -> Value -> EffPromise (Either Error Json)

removeCurator :: String -> Value -> Aff (Either JsonOrJsError Unit)
removeCurator s v = toAffDecodeResult $ removeCuratorImpl Right Left s v

foreign import acceptInviteImpl :: RightF -> LeftF -> Value -> EffPromise (Either Error Json)

acceptInvite :: Value -> Aff (Either JsonOrJsError Unit)
acceptInvite v = toAffDecodeResult $ acceptInviteImpl Right Left v

foreign import myStatusImpl :: RightF -> LeftF -> Value -> EffPromise (Either Error Json)

myStatus :: Value -> Aff (Either JsonOrJsError MyStatus.Value)
myStatus v = toAffDecodeResult $ myStatusImpl Right Left v

foreign import addProjectImpl :: RightF -> LeftF -> Int -> Value -> EffPromise (Either Error Json)

addProject :: Int -> Value -> Aff (Either JsonOrJsError Unit)
addProject i v = toAffDecodeResult $ addProjectImpl Right Left i v

foreign import removeProjectImpl :: RightF -> LeftF -> Int -> Value -> EffPromise (Either Error Json)

removeProject :: Int -> Value -> Aff (Either JsonOrJsError Unit)
removeProject i v = toAffDecodeResult $ removeProjectImpl Right Left i v

foreign import commentImpl :: RightF -> LeftF -> String -> Int -> Int -> Value -> EffPromise (Either Error Json)

comment :: String -> Int -> Int -> Value -> Aff (Either JsonOrJsError Unit)
comment c pi ci v = toAffDecodeResult $ commentImpl Right Left c pi ci v

foreign import toggleCommentingImpl :: RightF -> LeftF -> Value -> EffPromise (Either Error Json)

toggleCommenting :: Value -> Aff (Either JsonOrJsError Unit)
toggleCommenting v = toAffDecodeResult $ toggleCommentingImpl Right Left v

foreign import getCuratorsImpl :: RightF -> LeftF -> Int -> Int -> Value -> EffPromise (Either Error Json)

getCurators :: Int -> Int -> Value -> Aff (Either JsonOrJsError (Array ProfileApi.Value))
getCurators l o v = toAffDecodeResult $ getCuratorsImpl Right Left l o v

foreign import getManagersImpl :: RightF -> LeftF -> Int -> Int -> Value -> EffPromise (Either Error Json)

getManagers :: Int -> Int -> Value -> Aff (Either JsonOrJsError (Array ProfileApi.Value))
getManagers l o v = toAffDecodeResult $ getManagersImpl Right Left l o v

foreign import getProjectsImpl :: RightF -> LeftF -> Int -> Int -> Value -> EffPromise (Either Error Json)

getProjects :: Int -> Int -> Value -> Aff (Either JsonOrJsError (Array Project.Value))
getProjects l o v = toAffDecodeResult $ getProjectsImpl Right Left l o v
