# Hexvault

## Setup
1. Put the Hexvault installer (e.g. `hexvault90_x64linux.run`) in `./files/hexvault.run`
2. Put your "setup" script (IFYKYK) in `./files/setup.py`
3. `docker run -v /your/local/files:/opt/hexvault/files -p 65433:65433 hexvault`
4. Connect using the Hexvault client and create the initial administrator