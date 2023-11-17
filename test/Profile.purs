module Test.Profile where

import Prelude

import Data.Array as Array
import Data.Either (isLeft)
import MeowClient.Profile (api, sendComment, comments, deleteComment, follow, messagesCount, status, toggleCommenting)
import MeowClient.Profile.Status (Value(..))
import MeowClient.Session as Session
import Test.Spec (Spec, it)
import Test.Spec.Assertions (shouldEqual, shouldSatisfy)
import Test.Utils (unsafeUnwrapResult)

spec :: Session.Value -> Spec Unit
spec session = do
    it "gets api" do
        res <- unsafeUnwrapResult <$> api { username : "griffpatch", session : Session.anonymous }
        res.username `shouldEqual` "griffpatch"

    it "leaves a comment" do
        _ <- unsafeUnwrapResult <$> sendComment 201 0 "Hello!" { username : "unknown123", session }
        pure unit

    it "gets comments" do
        res <- unsafeUnwrapResult <$> comments 2 { username : "griffpatch", session : Session.anonymous }
        shouldSatisfy (Array.length res) (_ > 10)

    it "fails to delete comment" do
        res <- deleteComment 39203 { username : "griffpatch", session : Session.anonymous }
        isLeft res `shouldEqual` true

    it "gets status" do
        value <- unsafeUnwrapResult <$> status { username : "ceebee", session : Session.anonymous }
        value `shouldEqual` ScratchTeam
        
    it "follows" do
        _ <- unsafeUnwrapResult <$> follow { username : "griffpatch", session }
        pure unit

    it "unfollows" do
        _ <- unsafeUnwrapResult <$> follow { username : "griffpatch", session }
        pure unit
        
    it "gets messages count" do
        count <- unsafeUnwrapResult <$> messagesCount { username : "x__0", session : Session.anonymous }
        (count > 1000) `shouldEqual` true
    
    it "toggles commenting" do
        _ <- toggleCommenting { username : "scratch---pixel_tr", session }
        pure unit
