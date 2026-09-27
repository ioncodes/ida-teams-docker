#!/bin/sh
set -eu
. /usr/local/bin/server_common.sh

prepare_server /opt/lumina lumina_server.hexlic lumina
set -- /opt/lumina/lumina_server \
    --license-file /opt/lumina/lumina_server.hexlic \
    --config-file /opt/lumina/lumina.conf \
    --certchain-file /opt/lumina/tls/server.crt \
    --privkey-file /opt/lumina/tls/server.key

# A failed connection must abort startup, never trigger schema recreation.
tables=$(MYSQL_PWD=lumina mysql --connect-timeout=10 \
    -h lumina-mysql -P 3306 -u lumina -N -B lumina -e 'SHOW TABLES')
if [ -z "$tables" ]; then
    "$@" --recreate-schema lumina
else
    "$@" --upgrade-schema
fi
exec "$@" --port-number 65432
