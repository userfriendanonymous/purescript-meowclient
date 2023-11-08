module MeowClient.Project.Comment where

import MeowClient.Visibility as Visibility

type Value =
    { id :: Int
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
    }
