#!/bin/sh
set -eu
. /usr/local/bin/server_common.sh

prepare_server /opt/hexvault teams_server.hexlic hexvault
mkdir -p /opt/hexvault/files
set -- /opt/hexvault/vault_server \
    --license-file /opt/hexvault/teams_server.hexlic \
    --config-file /opt/hexvault/hexvault.conf \
    --vault-dir /opt/hexvault/files \
    --certchain-file /opt/hexvault/tls/server.crt \
    --privkey-file /opt/hexvault/tls/server.key

if [ ! -e /opt/hexvault/files/hexvault.sqlite3 ]; then
    # Never recreate a missing database over an existing vault's files.
    if [ -n "$(find /opt/hexvault/files -mindepth 1 -maxdepth 1 -print -quit)" ]; then
        echo "Vault directory is not empty but hexvault.sqlite3 is missing; refusing to initialize." >&2
        exit 1
    fi
    "$@" --recreate-schema
fi
"$@" --upgrade-schema
exec "$@" --port-number 65433
