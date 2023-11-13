module Test.Main where

import Prelude

import Data.Either (Either(..))
import Effect (Effect)
import Effect.Aff (Aff, launchAff_)
import MeowClient.Session as Session
import Partial.Unsafe (unsafeCrashWith)
import Test.Config as Config
import Test.Profile as TestProfile
import Test.Session as TestSession
import Test.Project as TestProject
import Test.Spec (Spec, describe, it)
import Test.Spec.Reporter (consoleReporter)
import Test.Spec.Runner (runSpec)

loggedIn :: Aff Session.Value
loggedIn = do
    config <- Config.load
    session <- Session.logIn config.username config.password
    case session of
        Left v -> unsafeCrashWith $ "Failed to log in: " <> show v
        Right v -> pure v

main :: Effect Unit
main = launchAff_ do
    session <- loggedIn
    runSpec [consoleReporter] (spec session)

spec :: Session.Value -> Spec Unit
spec session = do
    describe "session" $ TestSession.spec session
    -- describe "profile" $ TestProfile.spec session
    -- describe "project" $ TestProject.spec session
