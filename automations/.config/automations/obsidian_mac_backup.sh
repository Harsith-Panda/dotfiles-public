#!/bin/bash
set -euo pipefail

export PATH="/usr/bin:/bin:/usr/sbin:/sbin:/opt/homebrew/bin"
#LOGFILE="$HOME/ssd-sync.log"
#exec >>"$LOGFILE" 2>&1

VOLUME="/Volumes/SANDISK SSD"
SOURCE="$HOME/Harshi/Personal/Obsidian/Harshi's Vault"
DEST="/Volumes/SANDISK SSD/Obsidian/Harshi's Valut (Back Up)"

# Define folders to ignore (relative to SOURCE)
# workspace.json and cache change constantly and aren't needed for backup
EXCLUDES=(
    --exclude=".obsidian/workspace.json"
    --exclude=".obsidian/cache"
    --exclude=".DS_Store"
)

#echo "--- Disk Detected: Starting Sync at $(date) ---"

mkdir -p "$DEST"

# Initial sync
/usr/bin/rsync -av --delete "${EXCLUDES[@]}" "$SOURCE/" "$DEST/"

# Watch for changes with 5-second batching
/opt/homebrew/bin/fswatch -o --latency 5 "$SOURCE" | while read -r _; do
    #   echo "Change detected. Syncing..."
    /usr/bin/rsync -av --delete "${EXCLUDES[@]}" "$SOURCE/" "$DEST/" || true
done
