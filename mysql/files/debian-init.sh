#!/bin/bash

mysqld --initialize-insecure --user=mysql --basedir=/usr --datadir={{ mysql_datadir }}

pass=`grep '^password' /etc/mysql/debian.cnf  | head -1 | awk '{ print $3}'`
mysql -B -N <<EOF
USE mysql;
CREATE USER IF NOT EXISTS 'debian-sys-maint'@'localhost' IDENTIFIED BY '$pass';
GRANT ALL ON *.* TO 'debian-sys-maint'@'localhost' WITH GRANT OPTION;
FLUSH PRIVILEGES;
EOF

mysqladmin --user {{ mysql_root_user }} password \'${1}\'
