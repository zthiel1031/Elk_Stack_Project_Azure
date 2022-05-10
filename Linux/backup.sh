#!/bin/bash

#Create /var/backup
mkdir -p /var/backup

#Create new /var/backup/home.tar
tar cvf /var/backup/home.tar /home

# Move the file `/var/backup/home.tar` to `/var/backup/home.MMDDYYYY.tar`
mv /var/backup/home.tar /var/backup/home.01012020.tar

# Creates an archive of `/home` and saves it to `/var/backup/home.tar`
tar cvf /var/backup/system.tar /home

#List all files in `/var/backup`, including file sizes and create/overwrite file called `/var/backup/file_report.text`
ls -lh /var/backup > /var/backup/file_report.text

#Print how much free memory your machine has left. Create/overwrite file called `/var/backup/disk_report.txt`
free -h > /var/backup/disk_report.txt