module MeowClient.Studio.Project where

-- | Information of a project in a studio.
type Value =
    { id :: Int
    , title :: String
    , image :: String
    , creatorId :: Int
    , username :: String
    , avatar :: 
        { "90x90" :: String
        , "60x60" :: String
        , "55x55" :: String
        , "50x50" :: String
        , "32x32" :: String
        }
    , actorId :: Int
    }
    