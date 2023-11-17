module MeowClient.Profile.Comment.Reply where

-- | Reply of a comment on a profile.
type Value =
    { id :: String
    , username :: String
    , content :: String
    }
