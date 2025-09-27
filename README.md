# Docker Volume: Sender ➜ Receiver (Ubuntu 22.04)

This repo demonstrates **persistent data with Docker volumes** by writing a file in one
container (the *sender*) and reading it from another container (the *receiver*) using
**read-only** mounts.

## Prereqs
- Docker installed and running
- Linux/macOS/WSL shell (PowerShell users can convert commands)

---

## TL;DR — Commands Only

```bash
# 1) Create volume
docker volume create VOL

# 2) Start sender (interactive), mount volume at /data
docker run --name sender -it -v VOL:/data ubuntu:22.04 bash

# 3) Inside container (sender): write a message and verify
cd /data
echo "Hello from Narod (or your name)" > message.txt
cat message.txt
# Exit (this also stops/kills the container since it's interactive)
exit

# 4) Start receiver (interactive) with **read-only** mount
docker run --name receiver -it -v VOL:/data:ro ubuntu:22.04 bash

# 5) Inside container (receiver): read the message (cannot write due to :ro)
cd /data
cat message.txt
# Try writing to confirm it's read-only (should fail):
# echo "new" > message.txt   # expect: permission denied
exit
```

The file remains because it lives in the named **volume** `VOL`, not the container's filesystem.

---

## Step-by-step (with explanations)

1. **Create a named volume**
   ```bash
   docker volume create VOL
   ```

2. **Run the *sender* container in interactive mode with the volume mounted at `/data`**
   ```bash
   docker run --name sender -it -v VOL:/data ubuntu:22.04 bash
   ```
   - `--name sender`: names the container for easy reference
   - `-it`: interactive TTY
   - `-v VOL:/data`: mount named volume `VOL` to `/data` in the container

3. **Inside `sender` write a file to `/data` and exit**
   ```bash
   cd /data
   echo "Hello from Narod (or your name)" > message.txt
   cat message.txt
   exit
   ```
   Exiting kills the interactive container (by design here). Your file persists in the volume.

4. **Start the *receiver* container with the same volume but read-only**
   ```bash
   docker run --name receiver -it -v VOL:/data:ro ubuntu:22.04 bash
   ```

5. **Inside `receiver`, read the message**
   ```bash
   cd /data
   cat message.txt
   exit
   ```

---

## Extras

- Quick, non-interactive write (alternative to step 2–3):
  ```bash
  docker run --rm -v VOL:/data ubuntu:22.04 bash -lc 'echo "Auto message" > /data/message.txt && cat /data/message.txt'
  ```

- Inspect the volume:
  ```bash
  docker volume inspect VOL
  ```

- Clean up:
  ```bash
  docker rm -f sender receiver 2>/dev/null || true
  docker volume rm VOL
  ```

---

## Files

- `scripts/create_volume.sh` — create the named volume
- `scripts/run_sender.sh` — start the sender interactively
- `scripts/run_receiver_ro.sh` — start the receiver read-only
- `scripts/cleanup.sh` — remove containers and the volume
- `scripts/quick_write.sh` — optional non-interactive writer

Use the README flow for the exact task; scripts are convenience helpers.
