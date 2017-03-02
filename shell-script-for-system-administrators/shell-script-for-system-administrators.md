Like I mentioned in previous post, in this post I will introduce some most usefull shell scripts for system administrator  

#### Display system information  
```html  
#!/bin/bash
# Sample script written for Part 4 of the RHCE series
# This script will return the following set of system information:
# -Hostname information:
echo -e "\e[31;43m***** HOSTNAME INFORMATION *****\e[0m"
hostnamectl
echo ""
# -File system disk space usage:
echo -e "\e[31;43m***** FILE SYSTEM DISK SPACE USAGE *****\e[0m"
df -h
echo ""
# -Free and used memory in the system:
echo -e "\e[31;43m ***** FREE AND USED MEMORY *****\e[0m"
free
echo ""
# -System uptime and load:
echo -e "\e[31;43m***** SYSTEM UPTIME AND LOAD *****\e[0m"
uptime
echo ""
# -Logged-in users:
echo -e "\e[31;43m***** CURRENTLY LOGGED-IN USERS *****\e[0m"
who
echo ""
# -Top 5 processes as far as memory usage is concerned
echo -e "\e[31;43m***** TOP 5 MEMORY-CONSUMING PROCESSES *****\e[0m"
ps -eo %mem,%cpu,comm --sort=-%mem | head -n 6
echo ""
echo -e "\e[1;32mDone.\e[0m"
```  
Some explains:  
```html  
echo -e "\e[COLOR1;COLOR2m<YOUR TEXT HERE>\e[0m"
```  
**COLOR1** and **COLOR2** are the foreground and background colors

#### Automation tasks  
Example script below present three classic tasks that can be automated :
* update the local file database  
* find files with 777 permissions  
* alert when filesystem usage surpasses a defined limit  
```html 

#!/bin/bash
# Sample script to automate tasks:
# -Update local file database:
echo -e "\e[4;32mUPDATING LOCAL FILE DATABASE\e[0m"
updatedb
if [ $? == 0 ]; then
echo "The local file database was updated correctly."
else
echo "The local file database was not updated correctly."
fi
echo ""
# -Find and / or delete files with 777 permissions.
echo -e "\e[4;32mLOOKING FOR FILES WITH 777 PERMISSIONS\e[0m"
# Enable either option (comment out the other line), but not both.
# Option 1: Delete files without prompting for confirmation. Assumes GNU version of find.
#find -type f -perm 0777 -delete
# Option 2: Ask for confirmation before deleting files. More portable across systems.
find -type f -perm 0777 -exec rm -i {} +;
echo ""
# -Alert when file system usage surpasses a defined limit 
echo -e "\e[4;32mCHECKING FILE SYSTEM USAGE\e[0m"
THRESHOLD=30
while read line; do
# This variable stores the file system path as a string
FILESYSTEM=$(echo $line | awk '{print $1}')
# This variable stores the use percentage (XX%)
PERCENTAGE=$(echo $line | awk '{print $5}')
# Use percentage without the % sign.
USAGE=${PERCENTAGE%?}
if [ $USAGE -gt $THRESHOLD ]; then
echo "The remaining available space in $FILESYSTEM is critically low. Used: $PERCENTAGE"
fi
done < <(df -h --total | grep -vi filesystem)  
```

#### Database backup  
The script is a pretty basic useful in backing up the database
```html  
#!/bin/sh
now="$(date +'%d_%m_%Y_%H_%M_%S')"
filename="db_backup_$now".gz
backupfolder="/var/www/vhosts/example.com/httpdocs/backups"
fullpathbackupfile="$backupfolder/$filename"
logfile="$backupfolder/"backup_log_"$(date +'%Y_%m')".txt
echo "mysqldump started at $(date +'%d-%m-%Y %H:%M:%S')" >> "$logfile"
mysqldump --user=mydbuser--password=mypass --default-character-set=utf8 mydatabase | gzip > "$fullpathbackupfile"
echo "mysqldump finished at $(date +'%d-%m-%Y %H:%M:%S')" >> "$logfile"
chown myuser "$fullpathbackupfile"
chown myuser "$logfile"
echo "file permission changed" >> "$logfile"
find "$backupfolder" -name db_backup_* -mtime +8 -exec rm {} \;
echo "old files deleted" >> "$logfile"
echo "operation finished at $(date +'%d-%m-%Y %H:%M:%S')" >> "$logfile"
echo "*****************" >> "$logfile"
exit 0
``` 

#### Backup folders  
The script will take your input backup folder and destination folder and auto backup if you using crontab  

```html  
backup_folder=$1
dest_folder=$2
_date=$(date +%d-%m-%Y)
file_name="backup-$_date"
echo "backup is processing from $backup_folder to $dest_folder"
echo
zip -r $dest_folder/$file_name $backup_folder > /dev/null
# show notify after backuip
echo
echo "BACKUP succesfully!"
echo "filename backup: $file_name"
echo "File backup was save is: $dest_folder"
ls -al $dest_folder
cd ~
echo
```

#### Adding new use to linux system  
The script allows the root user or admin to add new users to the system is easy way by just typying the user name and password  
```html 

#!/bin/bash
# Script to add a user to Linux system
if [ $(id -u) -eq 0 ]; then
    read -p "Enter username : " username
    read -s -p "Enter password : " password
    egrep "^$username" /etc/passwd >/dev/null
    if [ $? -eq 0 ]; then
        echo "$username exists!"
        exit 1
    else
        pass=$(perl -e 'print crypt($ARGV[0], "password")' $password)
        useradd -m -p $pass $username
        [ $? -eq 0 ] && echo "User has been added to system!" || echo "Failed to add a user!"
    fi
else
    echo "Only root may add a user to the system"
    exit 2
fi
```  
#### High CPU Usage Script  
At times, we need to monitor the high CPU usage in the system. We can use the below script to monitor the high CPU usage  
```html  
#!/bin/bash
while [ true ] ;do
used=`free -m |awk 'NR==3 {print $4}'`

if [ $used -lt 1000 ] && [ $used -gt 800 ]; then
echo "Free memory is below 1000MB. Possible memory leak!!!" | /bin/mail -s "HIGH MEMORY ALERT!!!" user@mydomain.com


fi
sleep 5
done
```  
#### Disk usage  
This script will be useful to analyze the disk usage and if the reported disk space is more than 90 % an email will be sent to the administrator.  
```html  
#!/bin/sh
# set -x
# Shell script to monitor or watch the disk space
# It will send an email to $ADMIN, if the (free available) percentage of space is >= 90%.
# -------------------------------------------------------------------------
# Set admin email so that you can get email.
ADMIN="root"
# set alert level 90% is default
ALERT=90
# Exclude list of unwanted monitoring, if several partions then use "|" to separate the partitions.
# An example: EXCLUDE_LIST="/dev/hdd1|/dev/hdc5"
EXCLUDE_LIST="/auto/ripper"
#
#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
#
function main_prog() {
while read output;
do
#echo $output
  usep=$(echo $output | awk '{ print $1}' | cut -d'%' -f1)
  partition=$(echo $output | awk '{print $2}')
  if [ $usep -ge $ALERT ] ; then
     echo "Running out of space \"$partition ($usep%)\" on server $(hostname), $(date)" | \
     mail -s "Alert: Almost out of disk space $usep%" $ADMIN
  fi
done
}
if [ "$EXCLUDE_LIST" != "" ] ; then
  df -H | grep -vE "^Filesystem|tmpfs|cdrom|${EXCLUDE_LIST}" | awk '{print $5 " " $6}' | main_prog
else
  df -H | grep -vE "^Filesystem|tmpfs|cdrom" | awk '{print $5 " " $6}' | main_prog
fi  
```  




