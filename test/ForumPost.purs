module Test.ForumPost where

import Prelude

import Data.String (Pattern(..))
import Data.String as String
import Effect.Class (liftEffect)
import Effect.Console (log)
import MeowClient (Session)
import MeowClient.ForumPost (edit, info, source)
import Test.Spec (Spec, it)
import Test.Spec.Assertions (shouldEqual, shouldSatisfy)
import Test.Utils (unsafeUnwrapResult)

spec :: Session -> Spec Unit
spec session = do
    it "gets info" do
        v <- unsafeUnwrapResult <$> info { id : 5417201, session }
        v.author `shouldEqual` "colinmacc"
    
    it "gets source" do
        v <- unsafeUnwrapResult <$> source { id : 5417201, session }
        v `shouldSatisfy` String.contains (Pattern "hover")
        pure unit

    it "edits" do
        _ <- unsafeUnwrapResult <$> edit "Cool!" { id : 7648207, session }
        pure unit

    