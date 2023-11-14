module MeowClient.Session
  ( Value
  , auth
  , logIn
  , logOut
  , searchProjects
  , uploadToAssets
  , anonymous
  , messages
  , setSignature
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
import MeowClient.SearchProjects as SearchProjects
import MeowClient.SearchProjectsMode as SearchProjectsMode
import MeowClient.Session.Auth as Auth
import MeowClient.Utils (EffPromise, LeftF, RightF, decodeJsErrorOrJson, toAffDecodeResult)
import Node.Buffer (Buffer)
import Promise.Aff (Promise, toAffE)

type JsonOrJsError = JsonOrJsError.Value

foreign import data Value :: Type

foreign import anonymous :: Value

foreign import authImpl :: (forall a . a -> Maybe a) -> (forall a . Maybe a) -> Value -> Maybe Auth.Value

auth :: Value -> Maybe Auth.Value
auth = authImpl Just Nothing

foreign import logInImpl :: RightF -> LeftF -> String -> String -> Effect (Promise (Either String Value))

logIn ∷ String → String → Aff (Either String Value)
logIn u p = toAffE $ logInImpl Right Left u p

foreign import uploadToAssetsImpl :: RightF -> LeftF -> Buffer -> String -> Value -> Effect (Promise String)

uploadToAssets ∷ Buffer → String → Value → Aff String
uploadToAssets b e v = toAffE $ uploadToAssetsImpl Right Left b e v

foreign import searchProjectsImpl :: RightF -> LeftF -> Json -> Int -> Int -> String -> Value -> Effect (Promise (Either Error Json))

searchProjects ∷ SearchProjectsMode.Value → Int → Int → String → Value → Aff (Either JsonOrJsError (Array SearchProjects.Value))
searchProjects m o l q v = decodeJsErrorOrJson <$> (toAffE $ searchProjectsImpl Right Left (encodeJson m) o l q v)

foreign import messagesImpl :: RightF -> LeftF -> Int -> Int -> Value -> EffPromise (Either Error Json)

messages :: Int -> Int -> Value -> Aff (Either JsonOrJsError.Value (Array Message.Value))
messages l o v = toAffDecodeResult $ messagesImpl Right Left l o v

foreign import logOutImpl :: RightF -> LeftF -> Value -> Effect (Promise (Either String Unit))

logOut :: Value -> Aff (Either String Unit)
logOut s = toAffE $ logOutImpl Right Left s

foreign import setSignatureImpl :: RightF -> LeftF -> String -> Value -> EffPromise (Either Error Json)

setSignature :: String -> Value -> Aff (Either JsonOrJsError Unit)
setSignature c v = toAffDecodeResult $ setSignatureImpl Right Left c v
