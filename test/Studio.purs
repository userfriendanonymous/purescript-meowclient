module Test.Studio where

import Prelude

import Data.Array as Array
import Data.Either (isLeft)
import MeowClient (Session)
import MeowClient.Studio (acceptInvite, addProject, api, curators, follow, inviteCurator, managers, myStatus, projects, removeCurator, removeProject, sendComment, setDescription, setTitle, toggleCommenting, unfollow)
import Test.Spec (Spec, it)
import Test.Spec.Assertions (shouldEqual, shouldSatisfy)
import Test.Utils (unsafeUnwrapResult)

spec :: Session -> Spec Unit
spec session = do
    it "gets api" do
        info <- unsafeUnwrapResult <$> api { session, id : 34104548 }
        info.id `shouldEqual` 34104548

    it "follows" do
        unsafeUnwrapResult <$> follow { session, id : 34104548 }

    it "unfollows" do
        unsafeUnwrapResult <$> unfollow { session, id : 34104548 }
        
    it "sets title" do
        unsafeUnwrapResult <$> setTitle "T" { session, id : 33429796 }
        
    it "sets description" do
        unsafeUnwrapResult <$> setDescription "Description" { session, id : 33429796 }
        
    it "invites a curator" do
        unsafeUnwrapResult <$> inviteCurator "SCRATCH---PIXEL" { session, id : 33429796 }
        
    it "removes a curator" do
        unsafeUnwrapResult <$> removeCurator "SCRATCH---PIXEL" { session, id : 33429796 }
        
    it "fails to accepts invite" do
        result <- acceptInvite { session, id : 33429796 }
        result `shouldSatisfy` isLeft
        
    it "gets my status" do
        status <- unsafeUnwrapResult <$> myStatus { session, id : 33429796 }
        status.manager `shouldEqual` true

    it "adds a project" do
        _ <- addProject 730949772 { session, id : 33429796 }
        unsafeUnwrapResult <$> addProject 912122835 { session, id : 33429796 }

    it "removes a project" do
        unsafeUnwrapResult <$> removeProject 912122835 { session, id : 33429796 }

    it "leaves a comment" do
        _ <- unsafeUnwrapResult <$> sendComment 201 0 "Hello!" { session, id : 33429796 }
        pure unit

    it "toggles commenting" do
        unsafeUnwrapResult <$> toggleCommenting { session, id : 33429796 }

    it "gets curators" do
        items <- unsafeUnwrapResult <$> curators 10 20 { session, id : 34104548 }
        Array.length items `shouldEqual` 20

    it "gets managers" do
        items <- unsafeUnwrapResult <$> managers 0 4 { session, id : 34104548 }
        Array.length items `shouldEqual` 4

    it "gets projects" do
        items <- unsafeUnwrapResult <$> projects 2 9 { session, id : 34104548 }
        Array.length items `shouldEqual` 9
