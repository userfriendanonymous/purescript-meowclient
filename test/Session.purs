module Test.Session where

import Prelude

import Data.Array as Array
import Data.Either (Either(..))
import Data.Tuple (Tuple(..), fst)
import Effect.Aff (Aff)
import Effect.Class (liftEffect)
import Effect.Console (log)
import MeowClient.SearchProjectsMode as SPM
import MeowClient.Session (logOut, messages, searchProjects, setSignature, uploadToAssets)
import MeowClient.Session as Session
import Node.Buffer as Buffer
import Partial.Unsafe (unsafeCrashWith)
import Test.Config as Config
import Test.Spec (Spec, it)
import Test.Spec.Assertions (shouldEqual)
import Test.Utils (unsafeUnwrapResult)

spec :: Session.Value -> Spec Unit
spec session = do
    it "uploads to assets" do
        buf <- liftEffect $ Buffer.alloc 10
        response <- uploadToAssets buf "txt" session
        liftEffect $ log response

    it "searches projects" do
        items <- unsafeUnwrapResult <$> searchProjects SPM.Popular 2 10 "hello" Session.anonymous
        Array.length items `shouldEqual` 10

    it "gets messages" do
        items <- unsafeUnwrapResult <$> messages 0 10 session
        (Array.length items > 0) `shouldEqual` true

    it "logs out" do
        _ <- unsafeUnwrapResult <$> logOut session
        pure unit
        
    it "sets signature" do
        _ <- unsafeUnwrapResult <$> setSignature "Signature" session
        pure unit
