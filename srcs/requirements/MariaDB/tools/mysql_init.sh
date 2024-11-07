#!/bin/sh

# echo "CREATE DATABASE IF NOT EXISTS ${SQL_DATABASE};" > /etc/mysql/init.sql
# echo "CREATE USER IF NOT EXISTS '${SQL_USER}'@'%' IDENTIFIED BY '${SQL_PASSWORD}';" >> /etc/mysql/init.sql
# echo "GRANT ALL PRIVILEGES ON *.* TO '${SQL_USER}'@'%' WITH GRANT OPTION;" >> /etc/mysql/init.sql
# echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';" >> /etc/mysql/init.sql
# echo "FLUSH PRIVILEGES;" >> /etc/mysql/init.sql

# mysqld_safe

# systemctl status mariadb

echo "INCEPTION: STARTING MARIADB"
service mariadb start &&\
USER_EXISTS=$(mariadb -u "$SQL_ROOT_USER" -p"$SQL_ROOT_PASSWORD" -sse "SELECT EXISTS(SELECT 1 FROM mysql.user WHERE user = '$SQL_USER');")


if [ "$USER_EXISTS" -eq 1 ]; then
    echo "INCEPTION: User '$SQL_USER' already exists in the database."
else
	echo "INCEPTION:  We need to configure the database"

	echo "	creating database"
	mariadb -u${SQL_ROOT_USER} -p${SQL_ROOT_PASSWORD}  -e "CREATE DATABASE IF NOT EXISTS ${SQL_DATABASE};" &&\
	echo "	database created"
	echo "	creating user ${SQL_USER}"
	mariadb -u${SQL_ROOT_USER} -p${SQL_ROOT_PASSWORD}  -e "CREATE USER IF NOT EXISTS '${SQL_USER}'@'%' IDENTIFIED BY '${SQL_USER_PASSWORD}';" &&\
	echo "	user created"
	echo "	setting privileges for user ${SQL_USER}"
	mariadb -u${SQL_ROOT_USER} -p${SQL_ROOT_PASSWORD}  -e "GRANT ALL PRIVILEGES ON ${SQL_DATABASE}.* TO '${SQL_USER}'@'%';" &&\
	echo "	privileges done for user ${SQL_USER}"
	echo "	changing admin credentials"
	mariadb -u${SQL_ROOT_USER} -p${SQL_ROOT_PASSWORD}  -e "ALTER USER '${SQL_ROOT_USER}'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';" &&\
	echo "	admin credentials changed"
	echo "	flushing privileges to update all caches"
	mariadb -u${SQL_ROOT_USER} -p${SQL_ROOT_PASSWORD} -e "FLUSH PRIVILEGES;" && \
	echo "	caches updated"
fi
echo
echo "INCEPTION: SHUTTING DOWN MARIADB TO RESTART IN SAFE MODE "
mysqladmin -u${SQL_ROOT_USER} -p${SQL_ROOT_PASSWORD} shutdown &&\
mysqld_safe