![スクリーンショット 2019-11-23 23 05 17](https://user-images.githubusercontent.com/5633085/69479890-bf1b6f80-0e45-11ea-856a-6290a5c8430b.jpg)

## Environment

・ELB(h2o)
・app(ruby,unicorn,nginx)
・mysql5.7


# add host

```
sudo vim /etc/hosts
127.0.0.1 adachin.com
```

# make docker network

```
docker network create \
  --driver=bridge \
  --subnet=10.100.0.0/12 \
  --gateway=10.100.0.1 \
adachin
```

# RUN

```
docker-compose up -d
```

## deploy

- fix env
```
$ cd ~/www/ruby
$ cp config/mail.yml.example config/mail.yml
$ cp .env.example .env
$ vim .env
DATABASE_HOST="10.100.51.11"
$ cp ~/www/ruby/docker/app/dev_unicorn.rb ~/www/ruby/config/
```

```
$ docker exec -it --user deploy adachin-app-6-11 bash
# bundle install
# rake db:init
# unicorn_rails -c config/dev_unicorn.rb -E development -D
```

- Access

http://adachin.com/

