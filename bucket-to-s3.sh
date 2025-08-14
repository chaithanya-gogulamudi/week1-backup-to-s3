#!/bin/bash
# Variables
BUCKET_NAME="my-backup-bucket-142025"
BACKUP_SOURCE="$HOME/week1/backup_data"
DATE=$(date +%F)
# Create a backup folder if not exists
mkdir -p $BACKUP_SOURCE
# Example: Copy test files into backup folder
echo "This is a backup file created on $DATE" > $BACKUP_SOURCE/test_$DATE.txt
# Sync to S3
aws s3 sync $BACKUP_SOURCE s3://$BUCKET_NAME/week1/$DATE/
echo "Backup completed and uploaded to s3://$BUCKET_NAME/week1/$DATE/"

