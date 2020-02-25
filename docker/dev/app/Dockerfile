FROM ruby:2.5.7

ENV LANG C.UTF-8
ENV ENTRYKIT_VERSION 0.4.0
ENV QMAKE=/usr/lib/qt5/bin/qmake
ENV APP_ROOT /var/www/app

WORKDIR $APP_ROOT

# Setup UTC+9
RUN cp -p /etc/localtime /etc/localtime.UTC \
    && cp -p /usr/share/zoneinfo/Japan /etc/localtime

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

# make directory 
RUN mkdir -p $APP_ROOT

# build nokogiri
COPY gemrc/.gemrc /etc/gemrc/
RUN chmod +r /etc/gemrc
RUN bundle config --global build.nokogiri --use-system-libraries

# nginx
RUN groupadd nginx
RUN useradd -g nginx nginx
ADD nginx/nginx.conf /etc/nginx/nginx.conf
ADD nginx/adachin.conf /etc/nginx/conf.d/adachin.conf

# setting superviser
COPY supervisor/app.conf /etc/supervisor/conf.d/app.conf

# Service to run
CMD [ "/usr/bin/supervisord" ]
