module Test.Session where

import Prelude

import Data.Array as Array
import Effect.Class (liftEffect)
import Effect.Console (log)
import MeowClient.SearchMode as SearchMode
import MeowClient.Session (logOut, messages, searchProjects, setSignature, uploadToAssets)
import MeowClient.Session as Session
import Node.Buffer as Buffer
import Test.Spec (Spec, it)
import Test.Spec.Assertions (shouldEqual)
import Test.Utils (unsafeUnwrapResult)

spec :: Session.Value -> Spec Unit
spec session = do
    it "uploads to assets" do
        buf <- liftEffect $ Buffer.alloc 10
        response <- unsafeUnwrapResult <$> uploadToAssets buf "txt" session
        liftEffect $ log response

    it "searches projects" do
        items <- unsafeUnwrapResult <$> searchProjects SearchMode.Popular 2 10 "hello" Session.anonymous
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
