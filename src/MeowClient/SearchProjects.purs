module MeowClient.SearchProjects where

import Data.Maybe (Maybe)

-- | Project information returned from searching projects.
type Item =
    { id :: Number
    , title :: String
    , description :: String
    , instructions :: String
    , visibility :: String
    , public :: Boolean
    , commentsAllowed :: Boolean
    , isPublished :: Boolean
    , author ::
        { id :: Number
        , username :: String
        , scratchteam :: Boolean
        , history ::
            { joined :: String
            }
        , profile ::
            { id :: Maybe Number
            , images ::
                { "90x90" :: String
                , "60x60" :: String
                , "55x55" :: String
                , "50x50" :: String
                , "32x32" :: String
                }
            }
        }
    }