module MeowClient.CloudSocket
  ( Value
  , id
  , init
  , session
  , setVar
  , var
  , close
  )
  where

import Prelude

import Data.Argonaut (Json, decodeJson)
import Data.Either (Either(..))
import Data.Maybe (Maybe(..))
import Effect (Effect)
import Effect.Exception (Error)
import MeowClient.Session as Session
import MeowClient.Utils (LeftF, RightF)

foreign import data Value :: Type

foreign import initImpl :: RightF -> LeftF -> Int -> Session.Value -> Effect (Either Error Value)

init :: Int -> Session.Value -> Effect (Either Error Value)
init = initImpl Right Left

foreign import session :: Value -> Session.Value
foreign import id :: Value -> Int

foreign import setVarImpl :: RightF -> LeftF -> String -> String -> Value -> Effect (Either Error Unit)

setVar :: String -> String -> Value -> Effect (Either Error Unit)
setVar = setVarImpl Right Left

foreign import varImpl :: RightF -> LeftF -> String -> Value -> Effect (Either Error Json)

var :: String -> Value -> Effect (Either Error (Maybe String))
var n v = map
    ( decodeJson >>> case _ of
        Left _ -> Nothing
        Right o -> o
    ) <$> varImpl Right Left n v

foreign import closeImpl :: RightF -> LeftF -> Value -> Effect (Either Error Unit)

close :: Value -> Effect (Either Error Unit)
close v = closeImpl Right Left v