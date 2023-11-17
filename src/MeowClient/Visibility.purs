module MeowClient.Visibility where

import Prelude

import Data.Argonaut (class DecodeJson, class EncodeJson, JsonDecodeError(..), decodeJson, encodeJson)
import Data.Either (Either(..))
import Data.Generic.Rep (class Generic)
import Data.Show.Generic (genericShow)

-- | Visibility of a project or a studio.
data Value
    = Visible
    | Hidden

derive instance Generic Value _
instance Show Value where
    show = genericShow

instance EncodeJson Value where
    encodeJson = case _ of
        Visible -> encodeJson "visible"
        Hidden -> encodeJson "hidden"

instance DecodeJson Value where
    decodeJson j = do
        str <- decodeJson j
        case str of
            "visible" -> Right Visible
            "hidden" -> Right Hidden
            _ -> Left $ TypeMismatch "unknown branch"
