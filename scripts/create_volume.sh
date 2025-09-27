#!/usr/bin/env bash
set -euo pipefail
docker volume create VOL
docker volume ls | grep VOL || true
