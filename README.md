various-util
============

A set of scripts for different purposes. 

*backUp.sh

This script is a simple tool for archiving and compressing the directories you specify. You need to define the type of compression, target folders and output directory in the script and then set a cron job to let this script run how often you want. More than a technical solution, it is a simple solution and a good example of the use of arrays  in bash.

*nfsMounter.sh

nfsMounter is a script that will check if an nfs mount point is not mounted and will try to mount it. Again, this script works better if set up as a cron job.