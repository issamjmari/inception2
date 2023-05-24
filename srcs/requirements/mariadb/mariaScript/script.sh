#!/bin/sh

cat << EOF > /etc/mysql/my.cnf
[mysqld]
user = root
port = 3306
socket = /var/run/mysqld/mysqld.sock
bind-address = 0.0.0.0
EOF
mysql_install_db

service mysql start
echo "CREATE DATABASE IF NOT EXISTS $WP_DBNAME ;" > db1.sql
echo "CREATE USER IF NOT EXISTS '$WP_DBUSR'@'%' IDENTIFIED BY '$WP_DBPWD' ;" >> db1.sql
echo "GRANT ALL PRIVILEGES ON $WP_DBNAME.* TO '$WP_DBUSR'@'%' ;" >> db1.sql
echo "FLUSH PRIVILEGES;" >> db1.sql
mysql < db1.sql
service mysql stop
mysqld