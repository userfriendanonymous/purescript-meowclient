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

-- | Connection to a project's clouddata ("socket").
foreign import data Value :: Type

foreign import initImpl :: RightF -> LeftF -> Int -> Session.Value -> Effect (Either Error Value)

-- | Initializes a new cloud connection.
-- | 
-- | `init [project id] [session]`
-- | ### Example
-- | ```purescript
-- | do
-- |    result <- init 441270032 session
-- |    case result of
-- |        Left error -> -- ...
-- |        Right cloudSocket -> -- ...
-- | ```
init :: Int -> Session.Value -> Effect (Either Error Value)
init = initImpl Right Left

-- | Retrieves session from a cloud socket.
-- | 
-- | `session [cloud socket]`
-- | ### Example
-- | ```purescript
-- | do
-- |    let session' = session cloudSocket
-- | ```
foreign import session :: Value -> Session.Value

-- | Retrieves project id from a cloud socket.
-- | 
-- | `id [cloud socket]`
-- | ### Example
-- | ```purescript
-- | do
-- |    let projectId = id cloudSocket
-- | ```
foreign import id :: Value -> Int

foreign import setVarImpl :: RightF -> LeftF -> String -> String -> Value -> Effect (Either Error Unit)

-- | Sets a variable.
-- | 
-- | `setVar [name] [value] [cloud socket]`
-- | ### Example
-- | ```purescript
-- | do
-- |    result <- setVar "name" "03958200150930301"
-- |    case result of
-- |        Left error -> -- ...
-- |        Right _ -> -- ...
-- | ```
setVar :: String -> String -> Value -> Effect (Either Error Unit)
setVar = setVarImpl Right Left

foreign import varImpl :: RightF -> LeftF -> String -> Value -> Effect (Either Error Json)

-- | Gets a variable.
-- | 
-- | `var [name] [cloud socket]`
-- | ### Example
-- | ```purescript
-- | do
-- |    result <- var "name"
-- |    case result of
-- |        Left error -> -- ...
-- |        Right maybeValue -> -- ...
-- | ```
var :: String -> Value -> Effect (Either Error (Maybe String))
var n v = map
    ( decodeJson >>> case _ of
        Left _ -> Nothing
        Right o -> o
    ) <$> varImpl Right Left n v

foreign import closeImpl :: RightF -> LeftF -> Value -> Effect (Either Error Unit)

-- | Closes a cloud connection.
-- | 
-- | `close [cloud socket]`
-- | ### Example
-- | ```purescript
-- | do
-- |    result <- close cloudSocket
-- |    case result of
-- |        Left error -> -- ...
-- |        Right _ -> -- ...
-- | ```
close :: Value -> Effect (Either Error Unit)
close v = closeImpl Right Left v