\# AWS EFS to S3 Automated Backup



\## Project Overview

This project demonstrates shared file storage using Amazon EFS and automated backups to Amazon S3 using EC2, IAM, AWS CLI, Bash scripting, and Linux cron.



\## Architecture

1\. Created a custom Amazon VPC.

2\. Configured subnets across Availability Zones.

3\. Configured EC2 instances within the VPC.

4\. Created an EFS file system with mount targets.

5\. Mounted EFS on a Linux EC2 instance.

6\. Configured an IAM role for AWS CLI access to S3.

7\. Created an S3 bucket for storing backups.

8\. Developed a Bash script to synchronize EFS files to S3.

9\. Configured cron to schedule periodic backups.

10\. Used logs and S3 listings to verify backup operations.



\## Technologies Used

\- AWS VPC

\- Amazon EC2

\- Amazon EFS

\- Amazon S3

\- AWS IAM

\- Amazon Linux 2023

\- AWS CLI

\- Bash

\- Linux cron



\## Backup Script

The backup script checks whether EFS is mounted and then synchronizes files to S3.



```bash

\#!/bin/bash



SOURCE="/root/efs-project/"

DESTINATION="s3://YOUR-BUCKET-NAME/efs-backup/"

LOG="/var/log/efs-s3-backup.log"



if ! mountpoint -q "$SOURCE"; then

&#x20;   echo "$(date): ERROR - EFS is not mounted" >> "$LOG"

&#x20;   exit 1

fi



if /usr/bin/aws s3 sync "$SOURCE" "$DESTINATION" >> "$LOG" 2>\&1; then

&#x20;   echo "$(date): Backup successful" >> "$LOG"

else

&#x20;   echo "$(date): Backup failed" >> "$LOG"

&#x20;   exit 1

fi

```



Replace `YOUR-BUCKET-NAME` with your actual bucket name when configuring the script in AWS.



\## Cron Schedule

Example schedule to run the script every five minutes:



```cron

\*/5 \* \* \* \* /usr/local/bin/efs-s3-backup.sh

```



\## Security

\- Use IAM roles instead of hardcoded AWS access keys.

\- Apply least-privilege permissions.

\- Restrict EFS access through security groups.

\- Never upload AWS credentials or private SSH keys to GitHub.



\## Project Status

The backup script was manually executed successfully, and backup files were observed in S3. The scheduled cron job should be verified separately before claiming that automatic backups were fully tested.



\## Future Improvements

\- Configure CloudWatch monitoring and alerts.

\- Add backup retention policies.

\- Test EFS access from another EC2 instance in a different Availability Zone.

\- Document restore and recovery procedures.



\## Disclaimer

This repository contains project documentation and scripts. Running AWS resources may incur charges.

