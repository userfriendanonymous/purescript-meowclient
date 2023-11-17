module MeowClient
  ( JsonOrJsError
  , Message
  , Session
  , Visibility
--   , acceptStudioInvite
--   , addProjectToStudio
--   , anonymousSession
--   , followUser
--   , isFavoritingProject
--   , isLovingProject
--   , logIn
--   , logOut
--   , messages
--   , profileComments
--   , projectApi
--   , projectCommentReplies
--   , projectComments
--   , searchProjects
--   , sendProfileComment
--   , sendProjectComment
--   , sendStudioComment
--   , setFavoritingProject
--   , setLovingProject
--   , setProjectCommenting
--   , setProjectInstructions
--   , setProjectNotesAndCredits
--   , setProjectThumbnail
--   , setProjectTitle
--   , setSignature
--   , shareProject
--   , studioApi
--   , studioCurators
--   , studioManagers
--   , toggleProfileCommenting
--   , unfollowUser
--   , unshareProject
--   , uploadToAssets
--   , userApi
--   , userMessagesCount
--   , userStatus
  )
  where

import MeowClient.JsonOrJsError as JsonOrJsError
import MeowClient.Message as Message
import MeowClient.Profile as Profile
import MeowClient.Project as Project
import MeowClient.Session as Session
import MeowClient.Studio as Studio
import MeowClient.Visibility as Visibility

type Session = Session.Value
type JsonOrJsError = JsonOrJsError.Value
type Visibility = Visibility.Value
type Message = Message.Value

-- anonymousSession = Session.anonymous
-- logIn = Session.logIn
-- logOut = Session.logOut
-- messages = Session.messages
-- searchProjects = Session.searchProjects
-- setSignature = Session.setSignature
-- uploadToAssets = Session.uploadToAssets

-- userApi = Profile.api
-- sendProfileComment = Profile.sendComment
-- profileComments = Profile.comments
-- followUser = Profile.follow
-- unfollowUser = Profile.unfollow
-- userMessagesCount = Profile.messagesCount
-- toggleProfileCommenting = Profile.toggleCommenting
-- userStatus = Profile.status

-- projectApi = Project.api
-- sendProjectComment = Project.sendComment
-- projectComments = Project.comments
-- projectCommentReplies = Project.commentReplies
-- isLovingProject = Project.isLoving
-- isFavoritingProject = Project.isFavoriting
-- setProjectCommenting = Project.setCommenting
-- setFavoritingProject = Project.setFavoriting
-- setLovingProject = Project.setLoving
-- setProjectTitle = Project.setTitle
-- setProjectInstructions = Project.setInstructions
-- setProjectNotesAndCredits = Project.setNotesAndCredits
-- setProjectThumbnail = Project.setThumbnail
-- shareProject = Project.share
-- unshareProject = Project.unshare

-- studioApi = Studio.api
-- acceptStudioInvite = Studio.acceptInvite
-- addProjectToStudio = Studio.addProject
-- sendStudioComment = Studio.sendComment
-- studioCurators = Studio.curators
-- studioManagers = Studio.managers
-- followStudio = Studio.follow
-- unfollowStudio = Studio.unfollow
