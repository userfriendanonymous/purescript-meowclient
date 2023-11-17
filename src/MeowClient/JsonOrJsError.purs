module MeowClient.JsonOrJsError where

import Prelude

import Data.Argonaut (JsonDecodeError)
import Data.Generic.Rep (class Generic)
import Data.Show.Generic (genericShow)
import Effect.Exception (Error)

-- | Error that happened because a JS function threw an error or JS -> PureScript parsing failed.
data Value
    = Json JsonDecodeError
    | Other Error

derive instance Generic Value _

instance Show Value where
    show = genericShow
    