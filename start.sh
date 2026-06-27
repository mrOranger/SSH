#!/bin/bash

set -eou pipefail

# Build of the application
docker compose --file docker-compose.ssh.yaml build --progress plain 2>&1 | tee logs/build.log

# Running the application
docker compose --file docker-compose.ssh.yaml up -d
