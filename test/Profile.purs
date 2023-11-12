module Test.Profile where

import Prelude

import Data.Array as Array
import Data.Either (isLeft)
import Data.Maybe (isJust)
import Data.Tuple (Tuple)
import MeowClient.Profile (api, comment, comments, deleteComment, follow, messagesCount, status, toggleCommenting)
import MeowClient.Profile as Profile
import MeowClient.Profile.Status (Value(..))
import MeowClient.Session as Session
import Test.Session (loggedIn, loggedInAndUsername)
import Test.Spec (Spec, it)
import Test.Spec.Assertions (shouldEqual)
import Test.Utils (unsafeUnwrapResult)

spec :: Spec Unit
spec = do
    it "gets api" do
        res <- unsafeUnwrapResult <$> api { username : "griffpatch", session : Session.anonymous }
        res.username `shouldEqual` "griffpatch"

    it "leaves a comment" do
        session <- loggedIn
        _ <- unsafeUnwrapResult <$> comment 201 0 "Hello!" { username : "unknown123", session }
        pure unit

    it "gets comments" do
        res <- unsafeUnwrapResult <$> comments 10 { username : "griffpatch", session : Session.anonymous }
        Array.length res `shouldEqual` 10

    it "fails to delete comment" do
        res <- deleteComment 39203 { username : "griffpatch", session : Session.anonymous }
        isLeft res `shouldEqual` true

    it "gets status" do
        value <- unsafeUnwrapResult <$> status { username : "ceebee", session : Session.anonymous }
        value `shouldEqual` ScratchTeam
        
    it "follows" do
        session <- loggedIn
        _ <- unsafeUnwrapResult <$> follow { username : "griffpatch", session }
        pure unit

    it "unfollows" do
        session <- loggedIn
        _ <- unsafeUnwrapResult <$> follow { username : "griffpatch", session }
        pure unit
        
    it "gets messages count" do
        count <- unsafeUnwrapResult <$> messagesCount { username : "griffpatch", session : Session.anonymous }
        (count > 1000) `shouldEqual` true
    
    it "fails to toggle commenting" do
        res <- toggleCommenting { username : "griffpatch", session : Session.anonymous }
        isLeft res `shouldEqual` true
