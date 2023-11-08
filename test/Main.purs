module Test.Main where

import Prelude

import Data.Either (Either(..), hush)
import Data.Maybe (fromJust)
import Effect (Effect)
import Effect.Aff (launchAff_)
import Effect.Class.Console (log)
import MeowClient.Profile as Profile
import MeowClient.Project as Project
import MeowClient.Session as Session
import MeowClient.Studio as Studio
import Partial.Unsafe (unsafePartial)

main :: Effect Unit
main = launchAff_ $ unsafePartial do
  let
    session = Session.value
    studio = { session, id : 25235219 }
  value <- Studio.getProjects 10 0 studio
  log $ show value
