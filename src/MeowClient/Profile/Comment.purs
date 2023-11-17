module MeowClient.Profile.Comment where

import MeowClient.Profile.Comment.Reply as Reply

-- | Comment on a profile.
type Value =
    { id :: String
    , username :: String
    , content :: String
    , replies :: Array Reply.Value
    }
