-- !!! EXAMPLES FOR PASSWORD CHANGES
-- SELECT CURRENT_USER(); Get logged user
-- UPDATE and SET are both valid ways for password change
-- SET PASSWORD FOR 'usrname'@'hostname' = PASSWORD('auth_string') / IDENTIFIED BY PASSWORD 'hash_string';
-- Set Password with wildcard % as below
-- SET PASSWORD FOR 'root'@'%.example.org' = PASSWORD('auth_string');
-- UPDATE mysql.USER SET Password=PASSWORD('new-password-here') WHERE USER='usrname'@'hostname'
-- Logs may contain password string after update !!!NOTICE!!!
-- CHECK http://dev.mysql.com/doc/refman/5.5/en/set-password.html Read IMPORTANT and CAUTION
-- END OF EXAMPLES !!!

-- !!! EXECUTE THIS SCRIPT AS ROOT USER !!!
use mysql;
--
DROP USER 'web01'@'localhost';
DROP USER 'web01_remote_1'@'192.168.238.0/255.255.255.0';
DROP USER 'web01_remote_2'@'192.168.222.0/255.255.255.0';
-- DO COMMIT
commit;

-- To revoke priviliges (remove)
-- REVOKE ALL PRIVILEGES, GRANT OPTION FROM 'johndoe'@'localhost';
-- REVOKE INSERT ON *.* FROM 'johndoe'@'localhost';
-- REVOKE INSERT ON SOMEDB.* FROM 'johndoe'@'localhost';
-- OR DROP the whole user and create again with new Priviliges
--SET @databasename='LOGCENTRAL'

-- Create root like user
CREATE USER 'web01'@'localhost' IDENTIFIED BY 'nova1';
GRANT ALL PRIVILEGES ON *.* TO 'web01'@'localhost' WITH GRANT OPTION;
FLUSH PRIVILEGES;
--
-- User for remote usage with restricted privileges
CREATE USER 'web01_remote_1'@'192.168.163.0/255.255.255.0' IDENTIFIED BY 'renova1';
GRANT SELECT ON concat(@databasename,".* TO 'web01_remote_1'@'192.168.163.0/255.255.255.0'";
GRANT INSERT ON concat(@databasename,".* TO 'web01_remote_1'@'192.168.163.0/255.255.255.0'";
GRANT UPDATE ON concat(@databasename,".* TO 'web01_remote_1'@'192.168.163.0/255.255.255.0'";
GRANT SHOW DATABASES LIKE '@databasename' TO 'web01_remote_1'@'192.168.163.0/255.255.255.0';
GRANT CREATE TEMPORARY TABLES ON concat(@databasename,".* TO 'web01_remote_1'@'192.168.163.0/255.255.255.0'";
GRANT PROCESS ON @databasename.* TO 'web01_remote_1'@'192.168.163.0/255.255.255.0';
GRANT SHOW VIEW ON concat(@databasename,".* TO 'web01_remote_1'@'192.168.163.0/255.255.255.0'";
GRANT EXECUTE ON concat(@databasename,".* TO 'web01_remote_1'@'192.168.163.0/255.255.255.0'";
GRANT REFERENCES ON concat(@databasename,".* TO 'web01_remote_1'@'192.168.163.0/255.255.255.0'";
GRANT FILE ON *.* TO 'web01_remote_1'@'192.168.163.0/255.255.255.0';
GRANT USAGE ON *.* TO 'web01_remote_1'@'192.168.163.0/255.255.255.0' WITH MAX_QUERIES_PER_HOUR 10000;
FLUSH PRIVILEGES;
--
-- User for remote usage for all tables in all databases with restricted privileges
CREATE USER 'web01_remote_2'@'192.168.222.0/255.255.255.0' IDENTIFIED BY 'renova2';
GRANT SELECT ON *.* TO 'web01_remote_2'@'192.168.222.0/255.255.255.0';
GRANT INSERT ON *.* TO 'web01_remote_2'@'192.168.222.0/255.255.255.0';
GRANT UPDATE ON *.* TO 'web01_remote_2'@'192.168.222.0/255.255.255.0';
GRANT SHOW DATABASES ON *.* TO 'web01_remote_2'@'192.168.222.0/255.255.255.0';
GRANT CREATE TEMPORARY TABLES ON *.* TO 'web01_remote_2'@'192.168.222.0/255.255.255.0';
GRANT PROCESS ON *.* TO 'web01_remote_2'@'192.168.222.0/255.255.255.0';
GRANT SHOW VIEW ON *.* TO 'web01_remote_2'@'192.168.222.0/255.255.255.0';
GRANT EXECUTE ON *.* TO 'web01_remote_2'@'192.168.222.0/255.255.255.0';
GRANT REFERENCES ON *.* TO 'web01_remote_2'@'192.168.222.0/255.255.255.0';
GRANT FILE ON *.* TO 'web01_remote_2'@'192.168.222.0/255.255.255.0';
GRANT USAGE ON *.* TO 'web01_remote_2'@'192.168.222.0/255.255.255.0' WITH MAX_QUERIES_PER_HOUR 100000;
FLUSH PRIVILEGES;
-- DO COMMIT
commit;
--
-- Describe USER Table privileges and SELECT all Privileges in table format
use mysql;
DESCRIBE user;
SELECT password, host, user, \n
CONCAT(Select_priv, Lock_tables_priv) AS selock, \n
 CONCAT(Insert_priv, Update_priv, Delete_priv, Create_priv, Drop_priv) AS modif, \n
 CONCAT(Grant_priv, References_priv, Index_priv, Alter_priv) AS meta, \n
 CONCAT(Create_tmp_table_priv, Create_view_priv, Show_view_priv) AS views, \n
 CONCAT(Create_routine_priv, Alter_routine_priv, Execute_priv) AS funcs, \n
 CONCAT(Repl_slave_priv, Repl_client_priv) AS replic, \n
 CONCAT(Super_priv, Shutdown_priv, Process_priv, File_priv, Show_db_priv, Reload_priv) AS admin \n
FROM mysql.user ORDER BY user, host;


