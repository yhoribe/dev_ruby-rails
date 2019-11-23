#!/bin/sh

if [ -n "$CUSTOM_HOST" ]; then
  find /etc/nginx/conf.d/ -type f -print0 | xargs -0 sed -i -E "s/dev([.-])/$CUSTOM_HOST\1/g"
fi

/usr/sbin/nginx
/usr/local/bundle/bin/unicorn_rails -c /var/ruby/config/dev_unicorn.rb -E development -D

while true
do
  sleep 10
done

