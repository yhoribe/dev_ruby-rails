#!/bin/sh

if [ -n "$CUSTOM_HOST" ]; then
  find /etc/h2o/conf.d/ -type f -print0 | xargs -0 sed -i -E "s/dev([.-])/$CUSTOM_HOST\1/g"
fi

/usr/bin/h2o -c /etc/h2o/h2o.conf

while true
do
  sleep 10
done

