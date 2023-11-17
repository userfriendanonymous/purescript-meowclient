module MeowClient.Session
  ( Auth
  , Value
  , anonymous
  , auth
  , logIn
  , logOut
  , messages
  , searchProjects
  , setSignature
  , uploadToAssets
  )
  where

import Prelude

import Data.Argonaut (Json, encodeJson)
import Data.Either (Either(..))
import Data.Maybe (Maybe(..))
import Effect (Effect)
import Effect.Aff (Aff)
import Effect.Exception (Error)
import MeowClient.JsonOrJsError as JsonOrJsError
import MeowClient.Message as Message
import MeowClient.SearchMode as SearchMode
import MeowClient.SearchProjects as SearchProjects
import MeowClient.Session.Auth as Auth
import MeowClient.Utils (EffPromise, LeftF, RightF, decodeJsErrorOrJson, toAffDecodeResult)
import Node.Buffer (Buffer)
import Promise.Aff (Promise, toAffE)

type Auth = Auth.Value

type JsonOrJsError = JsonOrJsError.Value

foreign import data Value :: Type

foreign import anonymous :: Value

foreign import authImpl :: (forall a . a -> Maybe a) -> (forall a . Maybe a) -> Value -> Maybe Auth.Value

-- | Extracts authentication information.
-- | 
-- | `auth [session]`
-- | ### Example
-- | ```purescript
-- | do
-- |    maybeInfo <- auth anonymous
-- |    case maybeInfo of
-- |        Just info -> -- ...
-- |        Nothing -> -- ...
-- | ```
auth :: Value -> Maybe Auth.Value
auth = authImpl Just Nothing

foreign import logInImpl :: RightF -> LeftF -> String -> String -> Effect (Promise (Either Error Value))

-- | Logs in with username and password.
-- | 
-- | `logIn [username] [password]`
-- | ### Example
-- | ```purescript
-- | do
-- |    result <- logIn "username" "password"
-- |    case result of
-- |        Left err -> -- ...
-- |        Right session -> -- ...
-- | ```
logIn ∷ String → String → Aff (Either Error Value)
logIn username password = toAffE $ logInImpl Right Left username password

foreign import uploadToAssetsImpl :: RightF -> LeftF -> Buffer -> String -> Value -> EffPromise (Either Error Json)

-- | Uploads a file to <https://assets.scratch.mit.edu/>.
-- |
-- | This can be used for adding images to be used in a forum post or signature.
-- |
-- | `uploadToAssets [buffer] [file extension] [session]`
-- | ### Example
-- | ```purescript
-- | do
-- |    result <- uploadToAssets buffer "txt" session
-- |    case result of
-- |        Left error -> -- ...
-- |        Right assetUrl -> -- ...
-- | ```
uploadToAssets ∷ Buffer → String → Value → Aff (Either JsonOrJsError.Value String)
uploadToAssets buffer extension v = toAffDecodeResult $ uploadToAssetsImpl Right Left buffer extension v

foreign import searchProjectsImpl :: RightF -> LeftF -> Json -> Int -> Int -> String -> Value -> Effect (Promise (Either Error Json))

-- | Searches projects.
-- |
-- | `searchProjects [mode] [offset] [limit] [query string] [session]`
-- | ### Example
-- | ```purescript
-- | import MeowClient.SearchMode as SearchMode
-- | do
-- |    result <- searchProjects SearchMode.Popular 0 20 "cat" session
-- |    case result of
-- |        Left error -> -- ...
-- |        Right projects -> -- ...
-- | ```
searchProjects ∷ SearchMode.Value → Int → Int → String → Value → Aff (Either JsonOrJsError (Array SearchProjects.Item))
searchProjects mode offset limit query v = decodeJsErrorOrJson <$> (toAffE $ searchProjectsImpl Right Left (encodeJson mode) offset limit query v)

foreign import messagesImpl :: RightF -> LeftF -> Int -> Int -> Value -> EffPromise (Either Error Json)

-- | Gets logged in user's messages.
-- | 
-- | `messages [offset] [limit] [session]`
-- | ### Example
-- | ```purescript
-- | do
-- |    result <- messages 0 20 session
-- |    case result of
-- |        Left error -> -- ...
-- |        Right messages -> -- ...
-- | ```
messages :: Int -> Int -> Value -> Aff (Either JsonOrJsError.Value (Array Message.Value))
messages offset limit v = toAffDecodeResult $ messagesImpl Right Left offset limit v

foreign import logOutImpl :: RightF -> LeftF -> Value -> Effect (Promise (Either Error Unit))

-- | Performs a log-out API call.
-- | 
-- | `logOut [session]`
-- | ### Note
-- | Session that's passed into this function, will not change.
-- | If it was logged in, it will stay logged in even after it's passed into this function.
-- | ### Example
-- | ```purescript
-- | do
-- |    result <- logOut session
-- |    case result of
-- |        Left error -> -- ...
-- |        Right _ -> -- ...
-- | ```
logOut :: Value -> Aff (Either Error Unit)
logOut v = toAffE $ logOutImpl Right Left v

foreign import setSignatureImpl :: RightF -> LeftF -> String -> Value -> EffPromise (Either Error Json)

-- | Sets logged in user's forums signature.
-- | 
-- | `setSignature [content] [session]`
-- | ### Example
-- | ```purescript
-- | do
-- |    result <- setSignature "My new signature!" session
-- |    case result of
-- |        Left error -> -- ...
-- |        Right _ -> -- ...
-- | ```
setSignature :: String -> Value -> Aff (Either JsonOrJsError Unit)
setSignature content v = toAffDecodeResult $ setSignatureImpl Right Left content v
