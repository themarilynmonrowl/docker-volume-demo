#!/usr/bin/env bash
set -euo pipefail
# Start an interactive Ubuntu 22.04 container named 'receiver' with VOL mounted at /data as read-only
docker run --name receiver -it -v VOL:/data:ro ubuntu:22.04 bash
