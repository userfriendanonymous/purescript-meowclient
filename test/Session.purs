module Test.Session where

import Prelude

import Data.Array as Array
import Data.Either (Either(..))
import Data.Tuple (Tuple(..), fst)
import Effect.Aff (Aff)
import Effect.Class (liftEffect)
import Effect.Console (log)
import MeowClient.SearchProjectsMode as SPM
import MeowClient.Session (logout, messages, searchProjects, uploadToAssets)
import MeowClient.Session as Session
import Node.Buffer as Buffer
import Partial.Unsafe (unsafeCrashWith)
import Test.Config as Config
import Test.Spec (Spec, it)
import Test.Spec.Assertions (shouldEqual)
import Test.Utils (unsafeUnwrapResult)

loggedInAndUsername :: Aff (Tuple Session.Value String)
loggedInAndUsername = do
    config <- Config.load
    session <- Session.logIn config.username config.password
    case session of
        Left v -> unsafeCrashWith $ "Failed to log in: " <> show v
        Right v -> pure $ Tuple v config.username

loggedIn :: Aff Session.Value
loggedIn = fst <$> loggedInAndUsername

spec :: Spec Unit
spec = do
    it "uploads to assets" do
        session <- loggedIn
        buf <- liftEffect $ Buffer.alloc 10
        response <- uploadToAssets buf "txt" session
        liftEffect $ log response

    it "searches projects" do
        let session = Session.anonymous
        items <- unsafeUnwrapResult <$> searchProjects SPM.Popular 0 10 "" session
        Array.length items `shouldEqual` 10

    it "gets messages" do
        session <- loggedIn
        items <- unsafeUnwrapResult <$> messages 0 10 session
        (Array.length items > 0) `shouldEqual` true

    it "logs out" do
        session <- loggedIn
        _ <- unsafeUnwrapResult <$> logout session
        pure unit
        