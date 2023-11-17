module MeowClient.Project.Comment.Reply where

import MeowClient.Visibility as Visibility

-- | Reply of a comment on a project.
type Value =
    { id :: Int
    , parentId :: Int
    , commenteeId :: Int
    , content :: String
    , datetimeCreated :: String
    , datetimeModified :: String
    , visibility :: Visibility.Value
    , author ::
        { id :: Int
        , username :: String
        , scratchteam :: Boolean
        , image :: String
        }
    , replyCount :: Int
    }
