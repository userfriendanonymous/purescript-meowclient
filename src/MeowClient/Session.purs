module MeowClient.Session
  ( Value
  , init
  , logout
  , searchProjects
  , uploadToAssets
  , value
  )
  where

import Prelude

import Data.Argonaut (Json)
import Data.Either (Either(..))
import Effect (Effect)
import Effect.Aff (Aff)
import Effect.Exception (Error)
import MeowClient.JsonOrJsError as JsonOrJsError
import MeowClient.SearchProjects as SearchProjects
import MeowClient.SearchProjectsMode as SearchProjectsMode
import MeowClient.Utils (LeftF, RightF, decodeJsErrorOrJson)
import Node.Buffer (Buffer)
import Promise.Aff (Promise, toAffE)

type JsonOrJsError = JsonOrJsError.Value

foreign import data Value :: Type

foreign import value :: Value

foreign import initImpl :: RightF -> LeftF -> String -> String -> Effect (Promise (Either String Value))

init ∷ String → String → Aff (Either String Value)
init u p = toAffE $ initImpl Right Left u p

foreign import uploadToAssetsImpl :: RightF -> LeftF -> Buffer -> String -> Value -> Effect (Promise String)

uploadToAssets ∷ Buffer → String → Value → Aff String
uploadToAssets b e v = toAffE $ uploadToAssetsImpl Right Left b e v

foreign import searchProjectsImpl :: RightF -> LeftF -> String -> Int -> Int -> SearchProjectsMode.Value -> Value -> Effect (Promise (Either Error Json))

searchProjects ∷ String → Int → Int → SearchProjectsMode.Value → Value → Aff (Either JsonOrJsError (Array SearchProjects.Value))
searchProjects q l o m s = decodeJsErrorOrJson <$> (toAffE $ searchProjectsImpl Right Left q l o m s)
    
-- foreign import getMessagesImpl :: (forall a b . a -> b -> Tuple a b) -> RightF -> LeftF -> Int -> Int -> Value -> Effect (Promise (Either String Json))

-- getMessages :: Int -> Int -> Value -> Aff (Either String (Array Message.Value))
-- getMessages l o s = do
--     res <- toAffE $ getMessagesImpl Tuple Right Left l o s
--     pure case res of
--         Left e -> Left e
--         Right j -> case decodeJson j of
--             Left e -> Left $ show e
--             Right v -> Right v

foreign import logoutImpl :: RightF -> LeftF -> Value -> Effect (Promise (Either String Unit))

logout :: Value -> Aff (Either String Unit)
logout s = toAffE $ logoutImpl Right Left s
