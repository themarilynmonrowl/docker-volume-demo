#!/usr/bin/env bash
set -euo pipefail
# Start an interactive Ubuntu 22.04 container named 'sender' with VOL mounted at /data
docker run --name sender -it -v VOL:/data ubuntu:22.04 bash
