FROM ruby:2.5.7

ENV LANG C.UTF-8
ENV ENTRYKIT_VERSION 0.4.0
ENV QMAKE=/usr/lib/qt5/bin/qmake
ENV APP_ROOT /var/www/app

WORKDIR $APP_ROOT

RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
    bash \
    build-essential \
    git \
    libcurl4-openssl-dev \
    libghc-yaml-dev \
    libqt5webkit5-dev \
    libxml2-dev \
    libxslt-dev \
    libyaml-dev \
    linux-headers-amd64 \
    default-mysql-client \
    nginx \
    nodejs \
    openssl \
    ruby-dev \
    ruby-json \
    sudo \
    tzdata \
    vim \
    supervisor \
    zlib1g-dev && \
    apt-get clean -y && \
    rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*

RUN wget https://github.com/progrium/entrykit/releases/download/v${ENTRYKIT_VERSION}/entrykit_${ENTRYKIT_VERSION}_Linux_x86_64.tgz \
  && tar -xvzf entrykit_${ENTRYKIT_VERSION}_Linux_x86_64.tgz \
  && rm entrykit_${ENTRYKIT_VERSION}_Linux_x86_64.tgz \
  && mv entrykit /bin/entrykit \
  && chmod +x /bin/entrykit \
  && entrykit --symlink

# copy app
RUN mkdir -p $APP_ROOT
COPY . $APP_ROOT
RUN cp $APP_ROOT/config/mail.yml.example $APP_ROOT/config/mail.yml
RUN cp docker/pre/app/.env.example $APP_ROOT/.env

# build nokogiri
COPY docker/pre/app/gemrc/.gemrc /etc/gemrc/
RUN chmod +r /etc/gemrc
RUN bundle config --global build.nokogiri --use-system-libraries

# bundle install
RUN bundle install --path vendor/bundle
RUN bundle exec rake assets:precompile RAILS_ENV=pre

# nginx
RUN groupadd nginx
RUN useradd -g nginx nginx
ADD docker/pre/app/nginx/nginx.conf /etc/nginx/nginx.conf
ADD docker/pre/app/nginx/adachin.conf /etc/nginx/conf.d/adachin.conf

# setting superviser
COPY docker/pre/app/supervisor/app.conf /etc/supervisor/conf.d/app.conf

# link logs
RUN ln -sf /dev/stdout /var/log/nginx/access.log
RUN ln -sf /dev/stderr /var/log/nginx/error.log

# Service to run
CMD [ "/usr/bin/supervisord" ]

