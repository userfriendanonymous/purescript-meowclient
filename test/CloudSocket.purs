module Test.CloudSocket where

import Prelude

import Data.Maybe (fromJust)
import Effect.Aff (Aff)
import Effect.Class (liftEffect)
import Effect.Console (log)
import MeowClient (Session)
import MeowClient.CloudSocket (Value, close, init, setVar, var)
import Partial.Unsafe (unsafePartial)
import Test.Spec (Spec, it)
import Test.Utils (unsafeUnwrapResult)

initSocket :: Session -> Aff Value
initSocket session = liftEffect $ unsafeUnwrapResult <$> init 881776495 session

spec :: Session -> Spec Unit
spec session = do
    it "sets var" do
        socket <- initSocket session
        _ <- liftEffect $ unsafeUnwrapResult <$> setVar "1" "400" socket
        pure unit

    it "gets var" do -- fails, obviously
        socket <- initSocket session
        value <- liftEffect $ unsafePartial fromJust <$> unsafeUnwrapResult <$> var "1" socket
        liftEffect $ log value
        pure unit

    it "closes" do
        socket <- initSocket session
        liftEffect $ unsafeUnwrapResult <$> close socket