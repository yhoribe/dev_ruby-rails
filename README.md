![69479890-bf1b6f80-0e45-11ea-856a-6290a5c8430b](https://user-images.githubusercontent.com/5633085/74911372-cbd94080-53ff-11ea-9317-4ec3b3e7453e.jpg)


## Environment

- dev
  - ELB(h2o)
  - app(ruby2.5.7,unicorn,nginx,supervisor)
  - mysql5.7

- pre
  - ECS/Fargate
  - deploy-container(alpine)→ssh/Confirm DB connection, use aws-cli
  - app

## dev
- Setting Repository
local mount

```
~/www/app
```

## Gem

- therubyracer

Please use Dockerfile because the gem does not work with Dockerfile-alpine

## add host

```
sudo vim /etc/hosts
127.0.0.1 adachin.com
```

## make docker network

```
docker network create \
  --driver=bridge \
  --subnet=10.100.0.0/12 \
  --gateway=10.100.0.1 \
adachin
```

## Run

```
cd dev
docker-compose up -d
```

## deploy

- fix env
```
$ cd ~/www/app
$ cp config/mail.yml.example config/mail.yml
$ cp .env.example .env
$ vim .env
DATABASE_HOST="10.100.51.11"
$ cp ~/www/app/docker/app/dev_unicorn.rb ~/www/app/config/
```

```
$ docker exec -it adachin-app-6-11 bash
# bundle install --path /root/vendor/bundle
# bundle exec rake db:init
# bundle exec unicorn_rails -c config/dev_unicorn.rb -E development -D
```

## Access

http://adachin.com/

## Pre

used circleci

## Manual

- build run
```
cd www/app/
docker build -f docker/pre/app/Dockerfile -t xxxxxxxxxx.dkr.ecr.ap-northeast-1.amazonaws.com/adachin-app-pre:latest .
docker run -it --name=adachin-app-pre xxxxxxxxx.dkr.ecr.ap-northeast-1.amazonaws.com/adachin-app-pre bash
vim .env
```

- ecr push
```
aws ecr get-login-password --profile pre-adachin-ecr | docker login --username AWS --password-stdin xxxxxxxxxxx.dkr.ecr.ap-northeast-1.amazonaws.com/
docker commit adachin-app-pre xxxxxxxx.dkr.ecr.ap-northeast-1.amazonaws.com/adachin-app-pre:latest
docker push xxxxxxxxx.dkr.ecr.ap-northeast-1.amazonaws.com/adachin-app-pre:latest
```

