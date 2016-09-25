#!/bin/bash

# initialize
export DEBIAN_FRONTEND=noninteractive

# NodeJS
apt-get -yq install nodejs nodejs-dev
echo -e "\e[31;43;1m NodeJS install success \e[0m "

# Sqlite
apt-get -yq install sqlite3 libsqlite3-dev
echo -e "\e[31;43;1m Sqlite install success \e[0m "

# MySQL
apt-get -yq install mysql-server mysql-client libmysqlclient-dev
mysql -u root -e "update mysql.user set plugin='mysql_native_password' WHERE User='root'; FLUSH PRIVILEGES;"
echo -e "\e[31;43;1m MySQL install success \e[0m "

# PostgreSQL
apt-get -yq install postgresql libpq-dev
echo -e "\e[31;43;1m PostgreSQL install success \e[0m "

# Nginx
apt-get -yq install nginx-full
echo -e "\e[31;43;1m Nginx install success \e[0m "

# Memcached
apt-get -yq install memcached
echo -e "\e[31;43;1m Memcached install success \e[0m "

# Redis
apt-get -yq install redis-server redis-tools
echo -e "\e[31;43;1m Redis install success \e[0m "

# RabbitMQ
apt-get -yq install rabbitmq-server
echo -e "\e[31;43;1m RabbitMQ install success \e[0m "
