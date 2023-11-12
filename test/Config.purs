module Test.Config where

import Prelude

import Data.Argonaut (decodeJson, jsonParser)
import Data.Either (Either(..))
import Effect.Aff (Aff)
import Node.Encoding (Encoding(..))
import Node.FS.Aff (readTextFile)
import Partial.Unsafe (unsafeCrashWith)

type Value = 
    { username :: String
    , password :: String
    }

load :: Aff Value
load = do
    content <- readTextFile UTF8 "config.json"
    pure case decodeJson <$> jsonParser content of
        Right (Right v) -> v
        _ -> unsafeCrashWith "Failed to parse config.json file contents"
        