module MeowClient.Profile.Status where

import Prelude

import Data.Argonaut (class DecodeJson, class EncodeJson, JsonDecodeError(..), decodeJson, encodeJson)
import Data.Either (Either(..))
import Data.Generic.Rep (class Generic)
import Data.Show.Generic (genericShow)

-- | User's status.
data Value 
    = Scratcher
    | NewScratcher
    | ScratchTeam

derive instance Eq Value
derive instance Generic Value _
instance Show Value where
    show = genericShow
    
instance EncodeJson Value where
    encodeJson = case _ of
        Scratcher -> encodeJson "Scratcher"
        NewScratcher -> encodeJson "New Scratcher"
        ScratchTeam -> encodeJson "Scratch Team"

instance DecodeJson Value where
    decodeJson j = do
        str <- decodeJson j
        case str of
            "Scratcher" -> pure Scratcher
            "New Scratcher" -> pure NewScratcher
            "Scratch Team" -> pure ScratchTeam
            _ -> Left $ TypeMismatch "unknown string"
