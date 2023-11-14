module Test.Forum where

import Prelude

import Data.Array as Array
import MeowClient (Session)
import MeowClient.Forum (createTopic, topics)
import Test.Spec (Spec, it)
import Test.Spec.Assertions (shouldSatisfy)
import Test.Utils (unsafeUnwrapResult)

spec :: Session -> Spec Unit
spec session = do
    it "gets topics" do
        items <- unsafeUnwrapResult <$> topics 2 { id : 31, session }
        shouldSatisfy (Array.length items) (_ > 10)

    -- Quite a dangerous test:
    -- it "creates a topic" do
    --     _ <- unsafeUnwrapResult <$> createTopic "Body" "title" { id : 31, session }
    --     pure unit
