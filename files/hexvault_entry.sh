#!/bin/sh

if [ ! -f /opt/hexvault/files/*.sqlite3 ]; then
    /opt/hexvault/vault_server --vault-dir /opt/hexvault/files --config-file /opt/hexvault/hexvault.conf --recreate-schema
fi

/opt/hexvault/vault_server --vault-dir /opt/hexvault/files --config-file /opt/hexvault/hexvault.conf --upgrade-schema
/opt/hexvault/vault_server --license-file /opt/hexvault/teams_server.hexlic --config-file /opt/hexvault/hexvault.conf --vault-dir /opt/hexvault/files --certchain-file /opt/hexvault/hexvault.crt --privkey-file /opt/hexvault/hexvault.key 