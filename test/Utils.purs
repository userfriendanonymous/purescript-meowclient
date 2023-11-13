module Test.Utils where

import Prelude

import Data.Either (Either(..))
import Partial (crashWith)
import Partial.Unsafe (unsafePartial)

unwrapResult :: forall a b . Show a => Partial => Either a b -> b
unwrapResult = case _ of
    Left error -> crashWith $ "Expected Right, found Left(" <> show error <> ")"
    Right v -> v

unsafeUnwrapResult :: forall a b . Show a => Either a b -> b
unsafeUnwrapResult = unsafePartial unwrapResult
