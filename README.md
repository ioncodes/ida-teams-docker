# ida-teams-docker
IDA Hexvault and Lumina dockerized, refer to `Dockerfile.Hexvault` and `Dockerfile.Lumina` respectively.

## Setup for Hexvault
1. Put the Hexvault installer (e.g. `hexvault90_x64linux.run`) in `./files/hexvault.run`
2. Put your "setup" script (IFYKYK) in `./files/setup_hexvault.py`
3. `docker run -p 65433:65433 hexvault`
4. Connect using the Hexvault client and create the initial administrator

## Setup for Lumina
1. Put the lumina installer (e.g. `lumina90_x64linux.run`) in `./files/lumina.run`
2. Put your "setup" script (IFYKYK) in `./files/setup_lumina.py`
3. Make a mysql container (refer to `docker-compose.yml`)
4. `docker run -p 65433:65433 hexvault` or something like that
5. Connect using IDA Pro and create the initial administrator

## Docker Compose (Hexvault & Lumina)
1. `docker compose up`

## Notes
The data should be persistent but honestly, idk what im doing so... Be careful and make backups :)