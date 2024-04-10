Infrastructure and Configuration scripts for setting up master.bioconductor.org instance

The sequence of execution of the scrips shold be 
1) Terraform to setup the AWS instance
2) server-setup.sh to update the apache
3) partition.sh to partition the disks created
4) rsync.sh to copy all the data from old disk

Note: the migration uses the old production disk

Make sure to replace /dev/sdX with the appropriate disk device name and /mnt/mydisk with your desired mount point.

Save this script to a file (e.g., partition_and_mount.sh), make it executable (chmod +x partition_and_mount.sh), and then run it with root privileges (sudo ./partition_and_mount.sh).

Note: 
Including -avzh in your rsync command would be:

-a: Archive mode (preserves permissions, ownership, etc.).
-v: Verbose output.
-z: Compression during transfer.
-h: Human-readable file sizes.