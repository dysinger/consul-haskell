{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ScopedTypeVariables #-}

module Network.Consul (
    deleteKey
  , getKey
  , initializeConsulClient
  , putKey
  , ConsulClient
) where

import Control.Monad.IO.Class
import Data.Text (Text)
import qualified Network.Consul.Internal as I
import Network.Consul.Types
import Network.HTTP.Client (defaultManagerSettings, newManager, ManagerSettings)
import Network.Socket (PortNumber)

initializeConsulClient :: MonadIO m => Text -> PortNumber -> Maybe ManagerSettings -> m ConsulClient
initializeConsulClient hostname port settings = do
  manager <- liftIO $ case settings of
                        Just x -> newManager x
                        Nothing -> newManager defaultManagerSettings
  return $ ConsulClient manager hostname port


{- Key Value -}


getKey :: MonadIO m => ConsulClient -> m (Maybe KeyValue)
getKey _client@ConsulClient{..} = undefined -- I.getKey ccManager ccHostname ccPort request

--listKeys :: MonadIO m => ConsulClient ->

putKey :: MonadIO m => ConsulClient -> KeyValuePut -> m Text
putKey _client@ConsulClient{..} request = I.putKey ccManager ccHostname ccPort request

deleteKey :: MonadIO m => ConsulClient -> Text -> m ()
deleteKey _client@ConsulClient{..} key = I.deleteKey ccManager ccHostname ccPort key


{- Agent -}

{- Helper Functions -}

{- ManagedSession is a session with an associated TTL healthcheck so the session will be terminated if the client dies. The healthcheck will be automatically updated. -}
{-createManagedSession :: MonadIO m => ConsulClient -> Maybe Text -> Int -> m (Maybe ManagedSession)
createManagedSession client name ttl = do
  undefined
-}
