#!/usr/bin/env bash
set -euo pipefail
# Non-interactive way to seed a message into the volume
docker run --rm -v VOL:/data ubuntu:22.04 bash -lc 'echo "Auto message from quick_write.sh" > /data/message.txt && ls -l /data && cat /data/message.txt'
