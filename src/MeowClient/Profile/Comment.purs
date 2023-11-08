module MeowClient.Profile.Comment where

import MeowClient.Profile.Comment.Reply as Reply

type Value =
    { id :: String
    , username :: String
    , content :: String
    , replies :: Array Reply.Value
    }
