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
import Partial.Unsafe (unsafePartial)

main :: Effect Unit
main = launchAff_ $ unsafePartial do
  let
    session = Session.value
    project = { session, id : 500455968 }
  value <- Project.commentReplies 328826514 0 20 project
  log $ show value
