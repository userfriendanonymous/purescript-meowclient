module MeowClient.ForumPost.Info where

import Prelude

import Data.JSDate (JSDate)

-- | Forum post information.
type Value =
    { content :: String
    , parsableContent :: Void
    , author :: String
    , date :: JSDate
    }
