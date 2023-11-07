module MeowClient.JsonOrJsError where

import Data.Argonaut (JsonDecodeError)
import Effect.Exception (Error)

data Value
    = Json JsonDecodeError
    | Other Error
