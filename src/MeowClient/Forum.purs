module MeowClient.Forum
  ( Pointer
  , Topic
  , createTopic
  , topics
  )
  where

import Prelude

import Data.Argonaut (Json)
import Data.Either (Either(..))
import Effect.Aff (Aff)
import Effect.Exception (Error)
import MeowClient (JsonOrJsError)
import MeowClient.Forum.Topic as Topic
import MeowClient.Session as Session
import MeowClient.Utils (EffPromise, LeftF, RightF, toAffDecodeResult)

type Topic = Topic.Value

-- | Forum pointer.
-- | ### Example
-- | ```purescript
-- | do
-- |    let forum = { id : 31, session }
-- |    result <- topics 1 forum
-- | ```
type Pointer =
    { session :: Session.Value
    , id :: Int
    }

foreign import topicsImpl :: RightF -> LeftF -> Int -> Pointer -> EffPromise (Either Error Json)

-- | Gets forum's topics.
-- | 
-- | `topics [page] [forum]`
-- | ### Example
-- | ```purescript
-- | do
-- |    result <- topics 3 forum
-- |    case result of
-- |        Left error -> -- ...
-- |        Right topics' -> -- ...
-- | ```
topics :: Int -> Pointer -> Aff (Either JsonOrJsError (Array Topic.Value))
topics page v = toAffDecodeResult $ topicsImpl Right Left page v

foreign import createTopicImpl :: RightF -> LeftF -> String -> String -> Pointer -> EffPromise (Either Error Json)

-- | Creates a topic in a forum.
-- | 
-- | `createTopic [body] [title] [forum]`
-- | ### Example
-- | ```purescript
-- | do
-- |    result <- createTopic "Welcome to this topic" "Topic title" forum
-- |    case result of
-- |        Left error -> -- ...
-- |        Right _ -> -- ...
-- | ```
createTopic :: String -> String -> Pointer -> Aff (Either JsonOrJsError Unit)
createTopic body title v = toAffDecodeResult $ createTopicImpl Right Left body title v
