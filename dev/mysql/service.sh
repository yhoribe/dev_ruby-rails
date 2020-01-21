#!/bin/bash

### Workaround for not start mysql on ovelay2
find /var/mysql/ -type f | xargs touch

service mysql start
service mysql restart

while true
do
  sleep 10
done
