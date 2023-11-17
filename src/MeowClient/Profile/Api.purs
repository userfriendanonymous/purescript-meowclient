module MeowClient.Profile.Api where

-- | User API information loaded from https://api.scratch.mit.edu/users/ID/.
type Value =
    { id :: Int
    , username :: String
    , scratchteam :: Boolean
    , history :: 
        { joined :: String
        }
    , profile ::
        { id :: Int
        , images ::
            { "90x90" :: String
            , "60x60" :: String
            , "55x55" :: String
            , "50x50" :: String
            , "32x32" :: String
            }
        , status :: String
        , bio :: String
        , country :: String
        }
    }