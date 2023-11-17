module MeowClient.Studio.MyStatus where

-- | Status of a user in a studio.
type Value =
    { manager :: Boolean
    , curator :: Boolean
    , invited :: Boolean
    , following :: Boolean
    }