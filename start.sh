#!/bin/bash

set -eou pipefail

docker compose --file docker-compose.ssh.yaml build --progress plain 2>&1 | tee logs/build.log
docker compose --file docker-compose.ssh.yaml up -d
