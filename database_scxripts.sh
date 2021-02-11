#!/usr/bin/bash
#
cur_user_home=$(eval echo "~$USER")

sudo mariadb -u root -p 
use mysql;
source $cur_user_home/web01/CRT_LOG_POINT_1.sql;
source $cur_user_home/web01/CreateUsersAndGrants3.SQL;commit;



