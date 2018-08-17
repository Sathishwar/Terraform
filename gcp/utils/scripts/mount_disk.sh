#!/bin/bash
set -ue
set -o pipefail

#Creating file system in the disk attached. Make sure to comment below line if you are attaching a disk with fs.
#It will clear the disk
sudo mkfs.ext4 -m 0 -F -E lazy_itable_init=0,lazy_journal_init=0,discard /dev/sdb

#Data directory of mysql
sudo mkdir /data
sudo mount -o discard,defaults /dev/sdb /data

#Adding in rc.local so that mounting will happen automatically after restarts
#Later need to make this clean
sudo chmod 0777 /etc/rc.local
sudo sed -i '$ d' /etc/rc.local 
printf "mount /dev/sdb /data\nexit 0\n" >> /etc/rc.local