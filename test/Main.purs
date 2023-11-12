module Test.Main where

import Prelude

import Effect (Effect)
import Effect.Aff (launchAff_)
import Test.Spec (Spec, describe, it)
import Test.Spec.Reporter (consoleReporter)
import Test.Spec.Runner (runSpec)
import Test.Session as TestSession
import Test.Profile as TestProfile

main :: Effect Unit
main = launchAff_ $ runSpec [consoleReporter] spec

spec :: Spec Unit
spec = do
    describe "session" TestSession.spec
    describe "profile" TestProfile.spec
    