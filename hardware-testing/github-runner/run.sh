#!/bin/bash
set -e
cd $(dirname $0)
./rsync.sh
ssh terrifi-gh-runner 'cd /home/terrifi/docker-compose && docker compose up -d --build'
