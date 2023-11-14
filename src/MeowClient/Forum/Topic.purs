module MeowClient.Forum.Topic where

import Data.Maybe (Maybe)

type Value =
    { sticky :: Maybe Boolean
    , title :: String
    , replyCount :: Int
    }
