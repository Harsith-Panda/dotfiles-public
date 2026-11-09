#!/bin/bash
set -euo pipefail

export PATH="/usr/bin:/bin:/usr/sbin:/sbin:/opt/homebrew/bin"

VOLUME="/Volumes/SANDISK SSD"
SOURCE="$HOME/Harshi/Personal/Obsidian/Harsith's Vault"
DEST="/Volumes/SANDISK SSD/Obsidian/Harsith's Vault (Back-Up)"

# These transient Obsidian files do not need to be backed up.
EXCLUDES=(
    --exclude=".obsidian/workspace.json"
    --exclude=".obsidian/cache"
    --exclude=".DS_Store"
)

mkdir -p "$DEST"

# Initial sync, followed by five-second batches whenever the vault changes.
/usr/bin/rsync -av --delete "${EXCLUDES[@]}" "$SOURCE/" "$DEST/"

/opt/homebrew/bin/fswatch -o --latency 5 "$SOURCE" | while read -r _; do
    /usr/bin/rsync -av --delete "${EXCLUDES[@]}" "$SOURCE/" "$DEST/" || true
done
