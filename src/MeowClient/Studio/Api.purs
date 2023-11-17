module MeowClient.Studio.Api where

import MeowClient.Visibility as Visibility

-- | Studio API information loaded from https://api.scratch.mit.edu/studios/ID/.
type Value =
    { id :: Int
    , title :: String
    , host :: Int
    , description :: String
    , visibility :: Visibility.Value
    , public :: Boolean
    , openToAll :: Boolean
    , commentsAllowed :: Boolean
    , image :: String
    , history ::
        { created :: String
        , modified :: String
        }
    , stats ::
        { comments :: Int
        , followers :: Int
        , managers :: Int
        , projects :: Int
        }
    }