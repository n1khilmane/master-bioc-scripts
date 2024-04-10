#!/bin/bash
# /mnt/data/extra/www/bioc/ is the directory on the old disk
#test
#make the target directory
sudo mkdir -p /extra/www/
sudo mkdir -p /mnt/data
sudo mkdir /extra/www/bioc/packages

#mount the olddisk
sudo mount /dev/nvme3n1p2 /mnt/data

#mount the content disk
sudo mount /dev/nvme1n1p1 /extra/www


# Sync bioc directory excluding packages/
sudo rsync -avzh --exclude='packages/' /mnt/data/extra/www/bioc /extra/www/bioc


#mount the packages disk 
sudo mount /dev/nvme2n1p1 /extra/www/bioc/packages

# Sync bioc/packages directory excluding stats/
sudo rsync -avzh --exclude='stats/' /mnt/data/extra/www/bioc/packages /extra/www/bioc/packages/