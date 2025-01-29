#!/bin/sh

DB_NAME="lumina"
DB_HOST="lumina-mysql"
DB_PORT="3306"
DB_USER="lumina"
DB_PASS="lumina"

if ! mysql -h "$DB_HOST" -P "$DB_PORT" -u "$DB_USER" -p"$DB_PASS" "$DB_NAME" -e "SHOW TABLES LIKE 'users'" | grep -q "users"; then
    /opt/lumina/lumina_server --config-file /opt/lumina/lumina.conf --recreate-schema lumina
fi

/opt/lumina/lumina_server --license-file /opt/lumina/lumina_server.hexlic --config-file /opt/lumina/lumina.conf --certchain-file /opt/lumina/lumina.crt --privkey-file /opt/lumina/lumina.key