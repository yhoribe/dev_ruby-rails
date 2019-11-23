#!/bin/bash

service mysql start

mysql -u root -h localhost -e "UPDATE mysql.user SET host = '%' WHERE user = 'root' AND host = 'localhost';"
mysql -u root -h localhost -e "UPDATE mysql.user SET plugin = 'mysql_native_password' WHERE user = 'root';"

service mysql restart

