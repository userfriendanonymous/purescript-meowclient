module Test.Main where

import Prelude

import Data.Either (Either(..))
import Effect (Effect)
import Effect.Aff (Aff, launchAff_)
import MeowClient.Session as Session
import Partial.Unsafe (unsafeCrashWith)
import Test.Config as Config
import Test.Forum as TestForum
import Test.ForumTopic as TestForumTopic
import Test.ForumPost as TestForumPost
import Test.Profile as TestProfile
import Test.Project as TestProject
import Test.Studio as TestStudio
import Test.Session as TestSession
import Test.CloudSocket as TestCloudSocket
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
    -- describe "session" $ TestSession.spec session
    -- describe "profile" $ TestProfile.spec session
    -- describe "project" $ TestProject.spec session
    describe "studio" $ TestStudio.spec session
    -- describe "forum" $ TestForum.spec session
    -- describe "forum topic" $ TestForumTopic.spec session
    -- describe "forum post" $ TestForumPost.spec session
    -- describe "cloud socket" $ TestCloudSocket.spec session
