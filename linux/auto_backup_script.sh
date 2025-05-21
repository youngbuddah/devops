#!/bin/bash

# Define backup source and destination
SOURCE_DIR="/home/username/Documents"
BACKUP_DIR="/home/username/backups"
BACKUP_FILE="$BACKUP_DIR/backup_$(date +'%Y-%m-%d_%H-%M-%S').tar.gz"

# Ensure backup directory exists
mkdir -p "$BACKUP_DIR"

# Create a compressed backup
tar -czf "$BACKUP_FILE" "$SOURCE_DIR"

echo "✅  Backup created: $BACKUP_FILE"

# Delete backups older than 7 days
find "$BACKUP_DIR" -type f -name "backup_*.tar.gz" -mtime +7 -exec rm {} \;

echo "🧹  Old backups deleted successfully!"


# to test the script - bash /home/username/backup.sh
# to add scheduler at daily 2 am
#    1) crontab -e
#    2) Add 0 2 * * * /bin/bash /home/username/backup.sh at the end
#    3) to verify cron job crontab -l
#    4) to verify execution log cat /var/log/syslog
#
                                                                                                                                                                                                                            25,31         All