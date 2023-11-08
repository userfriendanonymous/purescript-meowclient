module MeowClient.Project.Comment.Reply where

import MeowClient.Visibility as Visibility

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
