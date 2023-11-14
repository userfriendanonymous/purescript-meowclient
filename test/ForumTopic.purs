module Test.ForumTopic where

import Prelude

import Data.Array as Array
import MeowClient (Session)
import MeowClient.ForumTopic (follow, info, posts, reply, unfollow)
import Test.Spec (Spec, it)
import Test.Spec.Assertions (shouldSatisfy)
import Test.Utils (unsafeUnwrapResult)

spec :: Session -> Spec Unit
spec session = do
    it "gets info" do
        value <- unsafeUnwrapResult <$> info { id : 191972, session }
        value.replyCount `shouldSatisfy` (>) 100

    it "gets posts" do
        items <- unsafeUnwrapResult <$> posts 2 { id : 191972, session }
        Array.length items `shouldSatisfy` (_ > 5)

    -- Dangerous test!
    -- it "replies" do
    --     _ <- unsafeUnwrapResult <$> reply "Cool!" { id : 191972, session }
    --     pure unit

    it "follows" do
        _ <- unsafeUnwrapResult <$> follow { id : 191972, session }
        pure unit

    it "unfollows" do
        _ <- unsafeUnwrapResult <$> unfollow { id : 191972, session }
        pure unit