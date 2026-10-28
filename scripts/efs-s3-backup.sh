bash
#!/bin/bash

SOURCE="/root/efs-project/"
DESTINATION="s3://amzn-efs-project-files-storage/efs-backup/"
LOG="/var/log/efs-s3-backup.log"

# Verify that EFS is mounted
if ! mountpoint -q "$SOURCE"; then
    echo "$(date): ERROR - EFS is not mounted" >> "$LOG"
    exit 1
fi

# Synchronize EFS files to S3
if /usr/bin/aws s3 sync "$SOURCE" "$DESTINATION" >> "$LOG" 2>&1; then
    echo "$(date): Backup successful" >> "$LOG"
else
    echo "$(date): Backup failed" >> "$LOG"
    exit 1
fi
