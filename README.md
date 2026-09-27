# Hexvault and Lumina

IDA Hexvault and Lumina dockerized with Docker Compose.

## Setup

1. Put the Hexvault installer at `files/hexvault.run`.
2. Put the Lumina installer at `files/lumina.run`.
3. Put `setup_hexvault.py` and `setup_lumina.py` in `files/`.
4. Copy `.env.example` to `.env` and adjust it if needed.
5. Run:

   ```sh
   docker compose up --build -d
   ```

The setup scripts run during their respective image builds and create the
license files in the server directories. The scripts themselves are not stored
in the resulting images.

## Connect

- Hexvault: `127.0.0.1:65433`
- Lumina: `127.0.0.1:443`

Change the bind address or ports in `.env` if needed.

## Notes

Hexvault data, Lumina's MySQL data and both servers' TLS certificates are kept
in Docker volumes.
