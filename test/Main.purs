module Test.Main where

import Prelude

import Data.Either (Either(..), hush)
import Data.Maybe (fromJust)
import Effect (Effect)
import Effect.Aff (launchAff_)
import Effect.Class.Console (log)
import MeowClient.Profile (getStatus)
import MeowClient.Profile as Profile
import MeowClient.Session as Session
import Partial.Unsafe (unsafePartial)

main :: Effect Unit
main = launchAff_ $ unsafePartial do
  let
    session = Session.value
    profile = { session, username : "ceebee" }
  status <- hush >>> fromJust <$> getStatus profile
  log $ show status