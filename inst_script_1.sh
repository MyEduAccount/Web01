#!/usr/bin/bash
#
# Install Mariadb in CentOs linux
#
# Pre jobs
sudo apt -y autoremove;
# following package is needed by the script, but not installed:
sudo apt -y install apt-transport-https;
sudo systemctl stop mariadb;
#
pathx='/home/web01';
cd $pathx;
retvalue=`expr $?`;
if [ $retvalue != 0 ]; then
	echo "Folder "$pathx" does not exist - is created next.";
	mkdir $pathx;
	retvalue=`expr $?`;
	if [ $retvalue ! -eq 0 ]; then
		echo "Folder "$pathx" does creation failed - script execution ended to exit";
		exit;
	fi
fi
#
# check if repository exists
# sudo yum repoquery 
# Download curl and use curl to install mariadb
#sudo yum -y install curl;
##sudo apt -y install curl;
#
#
##curl -sS https://downloads.mariadb.com/MariaDB/mariadb_repo_setup | sudo bash;
##retvalue=`expr $?`;
##if [ $retvalue != 0 ]; then
##	echo "Download of mariadb_repo_setup failed - exit";
##	exit;
##fi
#
#sudo yum -y install ca-certificates;
##sudo apt -y install -y ca-certificates;
##retvalue=`expr $?`;
##if [ $retvalue != 0 ]; then
##	echo "Download and installation of ca-certificates failed - exit";
##	exit;
##
##fi
#
#sudo yum -y install mariadb;
sudo apt -y install mariadb-server;
retvalue=`expr $?`;
if [ $retvalue != 0 ]; then
	echo "Installation of mariadb failed - exit";
	exit;
fi
#
#sudo yum install python;
sudo apt -y install python3
retvalue=`expr $?`;
if [ $retvalue != 0 ]; then
	echo "installation of python failed - exit";
	exit;

fi
#

