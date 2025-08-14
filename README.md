--PROJECT STRUCTURE--
# Week1 - Automated Backup to AWS S3

##  Project Overview
This project automates the process of backing up files from a local directory to an **AWS S3 bucket** using a **Bash script** and **AWS CLI**.  
The script:
1. Generates a `.txt` backup file with the current date.
2. Saves it inside the `backup_data` directory within this project.
3. Uploads the backup file to the specified S3 bucket.
----

week1/
│── backup_data/ # Backup folder (stores generated files)
│ └── test_YYYY-MM-DD.txt # Example backup file
│── bucket-to-s3.sh # Script for backup & upload to S3
│── cron_test.log # Cron job log file (optional)
└── README.md # Documentation file
----

##  Prerequisites
Before running the script, make sure you have:
- **AWS CLI** installed → [Install AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
- An **S3 Bucket** created in AWS
- An **IAM User** with `AmazonS3FullAccess` policy
- AWS CLI configured:
```bash
aws configure
----
provide:

AWS Access Key ID
AWS Secret Access Key
Default region name
Default output format (optional)

----
Script:

#!/bin/bash

# Variables
BUCKET_NAME="your-bucket-name"   # Change this to your bucket name
BACKUP_DIR="$(pwd)/backup_data"
DATE=$(date +%Y-%m-%d)
FILE_NAME="test_${DATE}.txt"

# Create backup directory if it doesn't exist
mkdir -p "$BACKUP_DIR"

# Create a test file with date
echo "This is a backup file created on $DATE" > "$BACKUP_DIR/$FILE_NAME"

# Upload to S3
aws s3 cp "$BACKUP_DIR/$FILE_NAME" "s3://$BUCKET_NAME/$DATE/"

echo "Backup completed and uploaded to s3://$BUCKET_NAME/$DATE/"

----
How to use?
Clone the repository

$git clone https://github.com/<YOUR_USERNAME>/week1-backup-to-s3.git
$cd week1-backup-to-s3

Make Script Executable:
$chmod +x bucket-to-s3.sh

Update the s3 bucket name(it should me unique for every bucket)
$BUCKET_NAME="your-bucket-name"

Run the script
$./bucket-to-s3.sh

Expected Output:
Backup completed and uploaded to s3://your-bucket-name/YYYY-MM-DD/

Automating with cron
$crontab-e
0 9 * * * /home/<your-user>/week1/bucket-to-s3.sh >> /home/<your-user>/week1/cron_test.log 2>&1
paste this in vim

After 2–3 minutes:
$cat $HOME/cron_test.log
If you see timestamps being added every minute, cron is running fine.

