module MeowClient.Message where

import Prelude

import Data.Argonaut (class DecodeJson, JsonDecodeError(..), decodeJson)
import Data.Either (Either(..))
import Data.Generic.Rep (class Generic)
import Data.Show.Generic (genericShow)

data Value = Value Info Variant

instance Show Value where
    show (Value info variant) = "Value ( info = (" <> show info <> "), variant = (" <> show variant <> ") )"

instance DecodeJson Value where
    decodeJson j = do
        t :: { type :: String } <- decodeJson j
        variant <- case t.type of
            "studioactivity" -> StudioActivity <$> decodeJson j
            _ -> Left $ TypeMismatch "type field is not valid"
        info <- decodeJson j
        pure $ Value info variant

data Variant
    = StudioActivity StudioActivity
    | ForumPost ForumPost
    | AddComment AddComment
    | FollowUser FollowUser

derive instance Generic Variant _
instance Show Variant where
    show = genericShow

type Info =
    { id :: Number
    , datetimeCreated :: String
    , actorUsername :: String
    , actorId :: Number
    }

type StudioActivity =
    { galleryId :: Number
    , title :: String
    }

type ForumPost =
    { topicId :: Number
    , topicTitle :: String
    }

type AddComment =
    { commentType :: Number
    , commentObjId :: Number
    , commentId :: Number
    , commentFragment :: String
    , commentObjTitle :: String
    , commenteeUsername :: String
    }

type FollowUser =
    { followerdUserId :: Number
    , followedUsername :: String
    }
