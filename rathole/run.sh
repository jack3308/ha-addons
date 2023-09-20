#!/usr/bin/with-contenv bashio
CLIENT_ARCH=$(apk --print-arch)
REMOTE_ADDRESS=$(bashio::config 'remote_address')
LOCAL_ADDRESS=$(bashio::config 'local_address_ssl')
LOCAL_ADDRESS_INSEC=$(bashio::config 'local_address_http')
TOKEN=$(bashio::config 'token')
PUB_KEY=$(bashio::config 'public key')
PRV_KEY=$(bashio::config 'private key')
NAME1=$(bashio::config 'name_ssl')
NAME2=$(bashio::config 'name_http')


echo "[client]
remote_addr = \"$REMOTE_ADDRESS\"
default_token = \"$TOKEN\"

[client.services.$NAME1]
local_addr = \"$LOCAL_ADDRESS\"

[client.services.$NAME2]
local_addr = \"$LOCAL_ADDRESS_INSEC\"

[client.transport]
type = \"noise\"

[client.transport.noise]
pattern = "Noise_KK_25519_ChaChaPoly_BLAKE2s"
local_private_key = \"$PRV_KEY\"
remote_public_key = \"$PUB_KEY\"

cd /rathole-$CLIENT_ARCH

chmod +x rathole
./rathole client.toml
