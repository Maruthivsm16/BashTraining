#!/bin/bash
source="$1"         # directory to back up
dest="$2"           # local path or remote target
timestamp=$(date +"%Y%m%d_%H%M%S")
archive="backup_$timestamp.tar.gz"
if [ ! -d "$source" ]; then       # Check if source directory exists
    echo "Source directory does not exist!"
    exit 1
fi
echo "...Creating backup archive..."
tar -czf "/tmp/$archive" -C "$source" .
if [[ "$dest" == *"@"*":"* ]]; then         # Check if destination is a remote target
    echo "Sending backup to remote server: $dest"
    scp "/tmp/$archive" "$dest" || { echo "Failed to send backup to remote server!"; exit 1; }
else
    mkdir -p "$dest"
    echo "Saving backup to local path: $dest"
    mv "/tmp/$archive" "$dest/"
fi
echo "Backup completed successfully!"
