module MeowClient.Session.Auth where

type Value =
    { username :: String
    , csrfToken :: String
    , token :: String
    , cookieSet :: String
    -- , sessionJSON :: SessionJSON 
    }
    