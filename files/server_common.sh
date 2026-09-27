#!/bin/sh

prepare_server() {
    server_dir=$1
    license_name=$2
    certificate_name=$3
    if [ ! -s "$server_dir/$license_name" ]; then
        echo "Missing $server_dir/$license_name; the setup script must create it." >&2
        exit 1
    fi
    umask 027
    chmod 640 "$server_dir/$license_name"

    mkdir -p "$server_dir/tls"
    if [ ! -e "$server_dir/tls/server.key" ] && [ ! -e "$server_dir/tls/server.crt" ]; then
        openssl req -x509 -newkey rsa:4096 \
            -keyout "$server_dir/tls/server.key" \
            -out "$server_dir/tls/server.crt" \
            -days 365 -nodes -subj "/CN=$certificate_name"
    fi
    if [ ! -s "$server_dir/tls/server.key" ] || [ ! -s "$server_dir/tls/server.crt" ]; then
        echo "Both tls/server.key and tls/server.crt must exist and be nonempty." >&2
        exit 1
    fi
    chmod 640 "$server_dir/tls/server.key" "$server_dir/tls/server.crt"
}
