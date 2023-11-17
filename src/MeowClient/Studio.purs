module MeowClient.Studio
  ( Api
  , MyStatus
  , Pointer
  , Project
  , acceptInvite
  , addProject
  , api
  , curators
  , follow
  , inviteCurator
  , managers
  , myStatus
  , projects
  , removeCurator
  , removeProject
  , sendComment
  , setDescription
  , setTitle
  , toggleCommenting
  , unfollow
  )
  where

import Prelude

import Data.Argonaut (Json)
import Data.Either (Either(..))
import Effect.Aff (Aff)
import Effect.Exception (Error)
import MeowClient.JsonOrJsError as JsonOrJsError
import MeowClient.Profile.Api as ProfileApi
import MeowClient.Session as Session
import MeowClient.Studio.Api as Api
import MeowClient.Studio.MyStatus as MyStatus
import MeowClient.Studio.Project as Project
import MeowClient.Utils (RightF, LeftF, EffPromise, toAffDecodeResult)

type Api = Api.Value
type MyStatus = MyStatus.Value
type Project = Project.Value

-- | Studio pointer.
-- | ### Example
-- | ```purescript
-- | do
-- |    let studio = { id : 34104548, session }
-- |    result <- api studio
-- | ```
type Pointer =
    { session :: Session.Value
    , id :: Int
    }

foreign import apiImpl :: RightF -> LeftF -> Pointer -> EffPromise (Either Error Json)

-- | Gets API information.
-- | 
-- | `api [studio]`
-- | ### Example
-- | ```purescript
-- | do
-- |    result <- api { session, id : 34104548 }
-- |    case result of
-- |        Left error -> -- ...
-- |        Right info -> -- ...
-- | ```
api :: Pointer -> Aff (Either JsonOrJsError.Value Api.Value)
api v = toAffDecodeResult $ apiImpl Right Left v

foreign import followImpl :: RightF -> LeftF -> Pointer -> EffPromise (Either Error Json)

-- | Follows a studio.
-- | 
-- | `follow [studio]`
-- | ### Example
-- | ```purescript
-- | do
-- |    result <- follow { session, id : 34104548 }
-- |    case result of
-- |        Left error -> -- ...
-- |        Right _ -> -- ...
-- | ```
follow :: Pointer -> Aff (Either JsonOrJsError.Value Unit)
follow v = toAffDecodeResult $ followImpl Right Left v

foreign import unfollowImpl :: RightF -> LeftF -> Pointer -> EffPromise (Either Error Json)

-- | Unfollows a studio.
-- | 
-- | `unfollow [studio]`
-- | ### Example
-- | ```purescript
-- | do
-- |    result <- unfollow { session, id : 34104548 }
-- |    case result of
-- |        Left error -> -- ...
-- |        Right _ -> -- ...
-- | ```
unfollow :: Pointer -> Aff (Either JsonOrJsError.Value Unit)
unfollow v = toAffDecodeResult $ followImpl Right Left v

foreign import setTitleImpl :: RightF -> LeftF -> String -> Pointer -> EffPromise (Either Error Json)

-- | Sets title of a studio.
-- | 
-- | `setTitle [content] [studio]`
-- | ### Example
-- | ```purescript
-- | do
-- |    result <- setTitle "New title" { session, id : 34104548 }
-- |    case result of
-- |        Left error -> -- ...
-- |        Right _ -> -- ...
-- | ```
setTitle :: String -> Pointer -> Aff (Either JsonOrJsError.Value Unit)
setTitle content v = toAffDecodeResult $ setTitleImpl Right Left content v

foreign import setDescriptionImpl :: RightF -> LeftF -> String -> Pointer -> EffPromise (Either Error Json)

-- | Sets description of a studio.
-- | 
-- | `setDescription [content] [studio]`
-- | ### Example
-- | ```purescript
-- | do
-- |    result <- setDescription "Welcome to the studio" { session, id : 34104548 }
-- |    case result of
-- |        Left error -> -- ...
-- |        Right _ -> -- ...
-- | ```
setDescription :: String -> Pointer -> Aff (Either JsonOrJsError.Value Unit)
setDescription content v = toAffDecodeResult $ setDescriptionImpl Right Left content v

foreign import inviteCuratorImpl :: RightF -> LeftF -> String -> Pointer -> EffPromise (Either Error Json)

-- | Invites a curator.
-- | 
-- | `inviteCurator [username] [studio]`
-- | ### Example
-- | ```purescript
-- | do
-- |    result <- inviteCurator "griffpatch" { session, id : 34104548 }
-- |    case result of
-- |        Left error -> -- ...
-- |        Right _ -> -- ...
-- | ```
inviteCurator :: String -> Pointer -> Aff (Either JsonOrJsError.Value Unit)
inviteCurator username v = toAffDecodeResult $ inviteCuratorImpl Right Left username v

foreign import removeCuratorImpl :: RightF -> LeftF -> String -> Pointer -> EffPromise (Either Error Json)

-- | Removes a curator.
-- | 
-- | `removeCurator [username] [studio]`
-- | ### Example
-- | ```purescript
-- | do
-- |    result <- removeCurator "griffpatch" { session, id : 34104548 }
-- |    case result of
-- |        Left error -> -- ...
-- |        Right _ -> -- ...
-- | ```
removeCurator :: String -> Pointer -> Aff (Either JsonOrJsError.Value Unit)
removeCurator username v = toAffDecodeResult $ removeCuratorImpl Right Left username v

foreign import acceptInviteImpl :: RightF -> LeftF -> Pointer -> EffPromise (Either Error Json)

-- | Accepts an invite to curate a studio.
-- | 
-- | `acceptInvite [studio]`
-- | ### Example
-- | ```purescript
-- | do
-- |    result <- acceptInvite { session, id : 34104548 }
-- |    case result of
-- |        Left error -> -- ...
-- |        Right _ -> -- ...
-- | ```
acceptInvite :: Pointer -> Aff (Either JsonOrJsError.Value Unit)
acceptInvite v = toAffDecodeResult $ acceptInviteImpl Right Left v

foreign import myStatusImpl :: RightF -> LeftF -> Pointer -> EffPromise (Either Error Json)

-- | Gets logged in user's status in a studio.
-- | 
-- | `myStatus [studio]`
-- | ### Example
-- | ```purescript
-- | do
-- |    result <- myStatus { session, id : 34104548 }
-- |    case result of
-- |        Left error -> -- ...
-- |        Right status -> -- ...
-- | ```
myStatus :: Pointer -> Aff (Either JsonOrJsError.Value MyStatus.Value)
myStatus v = toAffDecodeResult $ myStatusImpl Right Left v

foreign import addProjectImpl :: RightF -> LeftF -> Int -> Pointer -> EffPromise (Either Error Json)

-- | Adds a project to a studio.
-- | 
-- | `addProject [id] [studio]`
-- | ### Example
-- | ```purescript
-- | do
-- |    result <- addProject 912075221 { session, id : 34104548 }
-- |    case result of
-- |        Left error -> -- ...
-- |        Right _ -> -- ...
-- | ```
addProject :: Int -> Pointer -> Aff (Either JsonOrJsError.Value Unit)
addProject id v = toAffDecodeResult $ addProjectImpl Right Left id v

foreign import removeProjectImpl :: RightF -> LeftF -> Int -> Pointer -> EffPromise (Either Error Json)

-- | Removes a project from a studio.
-- | 
-- | `removeProject [id] [studio]`
-- | ### Example
-- | ```purescript
-- | do
-- |    result <- removeProject 912075221 { session, id : 34104548 }
-- |    case result of
-- |        Left error -> -- ...
-- |        Right _ -> -- ...
-- | ```
removeProject :: Int -> Pointer -> Aff (Either JsonOrJsError.Value Unit)
removeProject id v = toAffDecodeResult $ removeProjectImpl Right Left id v

foreign import sendCommentImpl :: RightF -> LeftF -> Int -> Int -> String -> Pointer -> EffPromise (Either Error Json)

-- | Leaves a comment on a studio.
-- | 
-- | `sendComment [commentee id] [parent id] [studio]`
-- | ### Example
-- | ```purescript
-- | do
-- |    result <- sendComment 0 0 { session, id : 34104548 }
-- |    case result of
-- |        Left error -> -- ...
-- |        Right commentId -> -- ...
-- | ```
sendComment :: Int -> Int -> String -> Pointer -> Aff (Either JsonOrJsError.Value Int)
sendComment commenteeId parentId content v = toAffDecodeResult $ sendCommentImpl Right Left commenteeId parentId content v

foreign import toggleCommentingImpl :: RightF -> LeftF -> Pointer -> EffPromise (Either Error Json)

-- | Toggles studio commenting.
-- | 
-- | `toggleCommenting [studio]`
-- | ### Example
-- | ```purescript
-- | do
-- |    result <- toggleCommenting { session, id : 34104548 }
-- |    case result of
-- |        Left error -> -- ...
-- |        Right _ -> -- ...
-- | ```
toggleCommenting :: Pointer -> Aff (Either JsonOrJsError.Value Unit)
toggleCommenting v = toAffDecodeResult $ toggleCommentingImpl Right Left v

foreign import curatorsImpl :: RightF -> LeftF -> Int -> Int -> Pointer -> EffPromise (Either Error Json)

-- | Gets studio's curators.
-- | 
-- | `curators [offset] [limit] [studio]`
-- | ### Example
-- | ```purescript
-- | do
-- |    result <- curators 0 20 { session, id : 34104548 }
-- |    case result of
-- |        Left error -> -- ...
-- |        Right curators' -> -- ...
-- | ```
curators :: Int -> Int -> Pointer -> Aff (Either JsonOrJsError.Value (Array ProfileApi.Value))
curators offset limit v = toAffDecodeResult $ curatorsImpl Right Left offset limit v

foreign import managersImpl :: RightF -> LeftF -> Int -> Int -> Pointer -> EffPromise (Either Error Json)

-- | Gets studio's managers.
-- | 
-- | `managers [offset] [limit] [studio]`
-- | ### Example
-- | ```purescript
-- | do
-- |    result <- managers 0 20 { session, id : 34104548 }
-- |    case result of
-- |        Left error -> -- ...
-- |        Right managers' -> -- ...
-- | ```
managers :: Int -> Int -> Pointer -> Aff (Either JsonOrJsError.Value (Array ProfileApi.Value))
managers offset limit v = toAffDecodeResult $ managersImpl Right Left offset limit v

foreign import projectsImpl :: RightF -> LeftF -> Int -> Int -> Pointer -> EffPromise (Either Error Json)

-- | Gets studio's projects.
-- | 
-- | `projects [offset] [limit] [studio]`
-- | ### Example
-- | ```purescript
-- | do
-- |    result <- projects 0 20 { session, id : 34104548 }
-- |    case result of
-- |        Left error -> -- ...
-- |        Right projects' -> -- ...
-- | ```
projects :: Int -> Int -> Pointer -> Aff (Either JsonOrJsError.Value (Array Project.Value))
projects offset limit v = toAffDecodeResult $ projectsImpl Right Left offset limit v
