FROM debian:bookworm-slim

RUN apt-get update

# Install python
RUN apt-get install -y python3

# Create volume for files
VOLUME /opt/hexvault/files

# Run installer in files/
COPY files/* /tmp/
RUN chmod +x /tmp/*.run
RUN /tmp/hexvault.run --mode unattended --initialization 1 --username hexvault --service 0 --prefix /opt/hexvault

# Run setup.py :)
RUN python3 /tmp/setup.py

# Use the example configuration
RUN cp /opt/hexvault/hexvault.conf.example /opt/hexvault/hexvault.conf

# Generate a self-signed certificate
RUN openssl req -x509 -newkey rsa:4096 -keyout /opt/hexvault/hexvault.key -out /opt/hexvault/hexvault.crt -days 365 -nodes -subj "/C=US/ST=Denial/L=Springfield/O=Dis/CN=hexvault"

# Fix permissions
RUN chmod 640 /opt/hexvault/hexvault.conf /opt/hexvault/hexvault.crt /opt/hexvault/hexvault.key /opt/hexvault/teams_server.hexlic

# Create database
RUN /opt/hexvault/vault_server --vault-dir /opt/hexvault/files --config-file /opt/hexvault/hexvault.conf --recreate-schema

# Cleanup
RUN rm -rf /tmp/*

# Start the server
CMD [                                                       \
    "/opt/hexvault/vault_server",                           \
    "--license-file", "/opt/hexvault/teams_server.hexlic",  \
    "--config-file", "/opt/hexvault/hexvault.conf",         \
    "--vault-dir", "/opt/hexvault/files",                   \
    "--certchain-file", "/opt/hexvault/hexvault.crt",       \
    "--privkey-file", "/opt/hexvault/hexvault.key"          \
    ]