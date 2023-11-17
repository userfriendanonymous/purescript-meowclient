module MeowClient.Session.Auth where

-- | Authentication information.
type Value =
    { username :: String
    , csrfToken :: String
    , token :: String
    , cookieSet :: String
    -- , sessionJSON :: SessionJSON 
    }
    