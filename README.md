# MeowClient

MeowClient JS library by @god286 ported to PureScript through FFI.

## Installation

Install `meowclient` with [Spago](https://github.com/purescript/spago):

```console
$ spago install meowclient
```

## Usage example
```purescript
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
                
```

## Documentation

`meowclient` documentation is stored in a few places:

1. Module documentation is [published on Pursuit](https://pursuit.purescript.org/packages/purescript-meowclient).
2. Written documentation is kept in the [docs directory](./docs).
3. Usage examples can be found in [the test suite](./test).

If you get stuck, there are several ways to get help:

- [Open an issue](https://github.com/purescript-contrib/purescript-meowclient/issues) if you have encountered a bug or problem.
- Ask general questions on the [PureScript Discourse](https://discourse.purescript.org) forum or the [PureScript Discord](https://purescript.org/chat) chat.

## Contributing

You can contribute to `meowclient` in several ways:

1. If you encounter a problem or have a question, please [open an issue](https://github.com/purescript-contrib/purescript-meowclient/issues). We'll do our best to work with you to resolve or answer it.

2. If you would like to contribute code, tests, or documentation, please [read the contributor guide](./CONTRIBUTING.md). It's a short, helpful introduction to contributing to this library, including development instructions.

3. If you have written a library, tutorial, guide, or other resource based on this package, please share it on the [PureScript Discourse](https://discourse.purescript.org)! Writing libraries and learning resources are a great way to help this library succeed.