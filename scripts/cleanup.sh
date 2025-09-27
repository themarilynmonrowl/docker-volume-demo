#!/usr/bin/env bash
set -euo pipefail
docker rm -f sender receiver 2>/dev/null || true
docker volume rm VOL 2>/dev/null || true
docker volume ls | grep VOL || echo "Volume VOL removed"
