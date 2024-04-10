#!/bin/bash

# Check if the script is being run as root
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root" 
    exit 1
fi

# Disk device name (change this according to your disk)
disk="/dev/sdX"

# Mount point directory
mount_point="/mnt/mydisk"

# Step 1: Partition the disk
echo "Partitioning the disk..."
fdisk $disk <<EOF
n
p
1


w
EOF

# Step 2: Format the partition
echo "Formatting the partition..."
mkfs.ext4 ${disk}1

# Step 3: Create a mount point
echo "Creating mount point..."
mkdir -p $mount_point

# Step 4: Mount the partition
echo "Mounting the partition..."
mount ${disk}1 $mount_point


echo "Disk partitioning and mounting completed successfully."
