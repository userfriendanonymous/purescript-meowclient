module Test.Project where

import Prelude

import Data.Array as Array
import Effect.Class (liftEffect)
import MeowClient.Project (api, commentReplies, comments, isFavoriting, isLoving, sendComment, setCommenting, setFavoriting, setInstructions, setLoving, setNotesAndCredits, setThumbnail, setTitle, share, unshare)
import MeowClient.Session as Session
import Node.Buffer as Buffer
import Test.Spec (Spec, it)
import Test.Spec.Assertions (shouldEqual)
import Test.Utils (unsafeUnwrapResult)

spec :: Session.Value -> Spec Unit
spec session = do
    it "gets api" do
        v <- unsafeUnwrapResult <$> api { id : 544213416, session : Session.anonymous }
        v.id `shouldEqual` 544213416

    it "gets comments" do
        v <- unsafeUnwrapResult <$> comments 2 8 { id : 544213416, session : Session.anonymous }
        (Array.length v) `shouldEqual` 8

    it "gets comment replies" do
        v <- unsafeUnwrapResult <$> commentReplies 1 3 219162888 { id : 419460779, session : Session.anonymous }
        (Array.length v) `shouldEqual` 3

    it "leaves a comment" do
        _ <- unsafeUnwrapResult <$> sendComment 0 0 "Hello!" { id : 419460779, session }
        pure unit

    it "sets commenting" do
        _ <- unsafeUnwrapResult <$> setCommenting true { id : 419460779, session }
        pure unit

    it "sets title" do
        _ <- unsafeUnwrapResult <$> setTitle "VR Engine - Pen Contest Entry []" { id : 419460779, session }
        pure unit

    it "sets instructions" do
        _ <- unsafeUnwrapResult <$> setInstructions "-Simple VR Engine-" { id : 419460779, session }
        pure unit

    it "sets notes and credits" do
        _ <- unsafeUnwrapResult <$> setNotesAndCredits "All by me" { id : 419460779, session }
        pure unit

    it "sets thumbnail" do
        buffer <- liftEffect $ Buffer.alloc 10
        _ <- unsafeUnwrapResult <$> setThumbnail buffer { id : 419460779, session }
        pure unit

    it "unshares" do
        _ <- unsafeUnwrapResult <$> unshare { id : 419460779, session }
        pure unit

    it "shares" do
        _ <- unsafeUnwrapResult <$> share { id : 419460779, session }
        pure unit

    it "checks if loving" do
        _ <- unsafeUnwrapResult <$> isLoving { id : 419460779, session }
        pure unit

    it "checks if favoriting" do
        _ <- unsafeUnwrapResult <$> isFavoriting { id : 419460779, session }
        pure unit

    it "sets loving" do
        _ <- unsafeUnwrapResult <$> setLoving true { id : 419460779, session }
        pure unit

    it "sets favoriting" do
        _ <- unsafeUnwrapResult <$> setFavoriting true { id : 419460779, session }
        pure unit
