#!/bin/bash
set -uo pipefail

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

sync_vault() {
    # The volume path disappears when the SSD is ejected. Do not sync until it
    # mounts again.
    [[ -d "$VOLUME" ]] || return 0
    mkdir -p "$DEST"
    /usr/bin/rsync -av --delete "${EXCLUDES[@]}" "$SOURCE/" "$DEST/"
}

is_volume_mounted() {
    /sbin/mount | /usr/bin/grep -Fq " on $VOLUME "
}

# Keep the source watcher independent of the SSD. The main loop detects each
# unmounted-to-mounted transition and immediately performs a full sync.
exec 3< <(/opt/homebrew/bin/fswatch -o --latency 5 "$SOURCE")
mounted=0

while true; do
    if is_volume_mounted; then
        if [[ "$mounted" -eq 0 ]]; then
            sync_vault || true
            mounted=1
        fi
    else
        mounted=0
    fi

    # fswatch batches vault changes for five seconds. Sync only when the SSD
    # is currently available.
    if IFS= read -r -t 1 _ <&3; then
        [[ "$mounted" -eq 1 ]] && sync_vault || true
    fi
done
