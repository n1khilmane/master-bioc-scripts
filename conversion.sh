#!/bin/bash

#Will copy the authorized_keys file from /mnt/data/home/ubuntu/.ssh/ to /home/ubuntu/.ssh/, but it won't overwrite the authorized_keys file in /home/ubuntu/.ssh/ if it's already there and identical. 
#If there are differences between the source and destination files, rsync will update the destination file accordingly.
#move authorized_keys
sudo rsync -av /mnt/data/home/ubuntu/.ssh/authorized_keys /home/ubuntu/.ssh/

#moving all the files from .ssh
#The {} brace expansion is used to specify multiple files in a single command. This command will transfer the id_rsa, id_rsa.pub, and known_hosts files from the source directory /mnt/data/home/ubuntu/.ssh to the destination directory /home/ubuntu/.ssh.
sudo rsync -av /mnt/data/home/ubuntu/.ssh/{id_rsa,id_rsa.pub,known_hosts} /home/ubuntu/.ssh/

#all the directories in /home
sudo rsync -av /mnt/data/home/{bioc-rsync,ubuntu,webadmin} /home/

#moved the bioc-resync,webadmin from /home to www-content disk and will create a symbolic link from /home to /extra/www/home
sudo rsync -av /mnt/data/home/{bioc-rsync,webadmin} /extra/www/home/

#created symbolic link for webadmin and bioc-resync
sudo ln -s /extra/www/home/webadmin /home/webadmin
sudo ln -s /extra/www/home/bioc-rsync /home/bioc-rsync

#moving etc/passwd , etc/shadow, etc/group, etc/gshadow
# Backup existing files (optional but highly recommended)
sudo cp /etc/passwd /etc/passwd_backup
sudo cp /etc/shadow /etc/shadow_backup
sudo cp /etc/group /etc/group_backup
sudo cp /etc/gshadow /etc/gshadow_backup

# Copy files from old disk to system disk
sudo cp /mnt/data/etc/passwd /etc/passwd
sudo cp /mnt/data/etc/shadow /etc/shadow
sudo cp /mnt/data/etc/group /etc/group
sudo cp /mnt/data/etc/gshadow /etc/gshadow

# Set permissions and ownership appropriately
sudo chmod 644 /etc/passwd /etc/group
sudo chmod 400 /etc/shadow /etc/gshadow
sudo chown root:root /etc/passwd /etc/group /etc/shadow /etc/gshadow

#moving /etc/hosts
sudo cp hosts hosts_backup
sudo cp /mnt/data/etc/hosts hosts

#moving /etc/ssh config files 
sudo cp sshd_config sshd_config_backup
sudo cp ssh_config sshconfig_backup

sudo cp /mnt/data/etc/ssh/ssh_config ssh_config
sudo cp /mnt/data/etc/ssh/sshd_config sshd_config