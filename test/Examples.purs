
module Test.Examples where

import Prelude

import Data.Either (Either(..))
import Data.Maybe (Maybe(..))
import Effect.Aff (Aff)
import Effect.Class (liftEffect)
import Effect.Class.Console (log)
import MeowClient.CloudSocket as Cloud
import MeowClient.Profile (follow)
import MeowClient.Profile as Profile
import MeowClient.Project (favorite, love)
import MeowClient.Project as Project
import MeowClient.Session (logIn)

-- Some interactions with users and projects
actions ∷ Aff Unit
actions = do
    result <- logIn "Username" "Password"
    case result of
        Left error -> log $ "error logging in: " <> show error
        Right session -> do
        
            let griffpatch = { username : "griffpatch", session }
            
            _ <- follow griffpatch
            _ <- Profile.sendComment' "Hello frield!" griffpatch

            let appel = { id : 60917032, session }

            _ <- love appel
            _ <- favorite appel
            _ <- Project.sendComment' "Amazing game!" appel

            pure unit
            
-- Cloud data interactions
cloud ∷ Aff Unit
cloud = do
    result <- logIn "Username" "Password"
    case result of
        Left error -> log $ "error logging in: " <> show error
        -- Connect
        Right session -> liftEffect $ Cloud.init 60917032 session >>= case _ of
            Left error -> log $ "error connecting to cloud: " <> show error

            Right socket -> do
                -- Get a cloud variable
                liftEffect $ Cloud.var "CLOUD1" socket >>= case _ of
                    Left error -> log $ "error getting a cloud variable: " <> show error
                    Right (Just value) -> log $ "variable CLOUD1 has value: " <> value
                    Right Nothing -> log $ "variable not found!"

                -- Set a cloud variable
                _ <- liftEffect $ Cloud.setVar "CLOUD2" "03294041439033800" socket
                
                -- Bye!!
                _ <- liftEffect $ Cloud.close socket

                pure unit