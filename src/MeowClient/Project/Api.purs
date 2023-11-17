module MeowClient.Project.Api where

import Data.Maybe (Maybe)

-- | Project API information loaded from https://api.scratch.mit.edu/projects/ID/.
type Value =
    { id :: Int
    , title :: String
    , description :: String
    , instructions :: String
    , visibility :: String
    , public :: Boolean
    , commentsAllowed :: Boolean
    , isPublished :: Boolean
    , author ::
        { id :: Int
        , username :: String
        , scratchteam :: Boolean
        , history ::
            { joined :: String
            }
        , profile ::
            { images ::
                { "90x90" :: String
                , "60x60" :: String
                , "55x55" :: String
                , "50x50" :: String
                , "32x32" :: String
                }
            }
        }
    , image :: String
    , images ::
        { "282x218" :: String
        , "216x163" :: String
        , "200x200" :: String
        , "144x108" :: String
        , "135x102" :: String
        , "100x80" :: String
        }
    , history ::
        { created :: String
        , modified :: String
        , shared :: String
        }
    , stats ::
        { views :: Int
        , loves :: Int
        , favorites :: Int
        , remixes :: Int
        }
    , remix ::
        { parent :: Maybe Int
        , root :: Maybe Int
        }
    , projectToken :: String
    }
