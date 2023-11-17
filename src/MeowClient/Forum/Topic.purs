module MeowClient.Forum.Topic where

import Data.Maybe (Maybe)

-- | Information of a topic in a forum.
type Value =
    { sticky :: Maybe Boolean
    , title :: String
    , replyCount :: Int
    }
