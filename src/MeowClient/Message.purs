module MeowClient.Message where

import Prelude

import Data.Argonaut (class DecodeJson, JsonDecodeError(..), decodeJson)
import Data.Either (Either(..))
import Data.Generic.Rep (class Generic)
import Data.Show.Generic (genericShow)

-- | Represents a message that users receive in their inbox.
data Value = Value Info Variant

instance Show Value where
    show (Value info variant) = "Value ( info = (" <> show info <> "), variant = (" <> show variant <> ") )"

instance DecodeJson Value where
    decodeJson j = do
        t :: { type :: String } <- decodeJson j
        variant <- case t.type of
            "studioactivity" -> StudioActivity <$> decodeJson j
            "forumpost" -> ForumPost <$> decodeJson j
            "addcomment" -> AddComment <$> decodeJson j
            "followuser" -> FollowUser <$> decodeJson j
            "loveproject" -> LoveProject <$> decodeJson j
            "favoriteproject" -> FavoriteProject <$> decodeJson j
            "remixproject" -> RemixProject <$> decodeJson j
            "becomehoststudio" -> BecomeHostStudio <$> decodeJson j
            "curatorinvite" -> CuratorInvite <$> decodeJson j
            _ -> Left $ TypeMismatch "type field is not valid"
        info <- decodeJson j
        pure $ Value info variant

-- | Type of a message with data.
data Variant
    = StudioActivity StudioActivity
    | ForumPost ForumPost
    | AddComment AddComment
    | FollowUser FollowUser
    | LoveProject LoveProject
    | FavoriteProject FavoriteProject
    | RemixProject RemixProject
    | BecomeHostStudio BecomeHostStudio
    | CuratorInvite CuratorInvite

derive instance Generic Variant _
instance Show Variant where
    show = genericShow

-- | General information about a message (independent of the message's type).
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
    { followedUserId :: Number
    , followedUsername :: String
    }

type LoveProject =
    { projectId :: Int
    , title :: String
    }

type FavoriteProject =
    { projectId :: Int
    , projectTitle :: String
    }

type RemixProject =
    { title :: String
    , parentId :: Int
    , parentTitle :: String
    }

type BecomeHostStudio =
    { formerHostUsername :: String
    , recipientId :: Int
    , recipientUsername :: String
    , galleryId :: Int
    , galleryTitle :: String
    , adminActor :: Boolean
    }

type CuratorInvite =
    { title :: String
    , galleryId :: Int
    }
