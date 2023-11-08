module MeowClient
  ( JsonOrJsError
  , Session
  )
  where

import MeowClient.JsonOrJsError as JsonOrJsError
import MeowClient.Session as Session

type Session = Session.Value
type JsonOrJsError = JsonOrJsError.Value
