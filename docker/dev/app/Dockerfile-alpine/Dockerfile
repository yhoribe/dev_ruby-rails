FROM ruby:2.5.7-alpine

ENV LANG C.UTF-8

ENV ENTRYKIT_VERSION 0.4.0

WORKDIR $APP_ROOT

# linux-headers: raindrops
# qt5-qtwebkit-dev: capybara-webkit
ENV BASE_PACKAGES="git openssl" \
    BUILD_PACKAGES="bash curl-dev ruby-dev build-base" \
    DEV_PACKAGES="zlib-dev libxml2-dev libxslt-dev tzdata yaml-dev mysql-dev nginx" \
    RUBY_PACKAGES="ruby-json yaml nodejs" \
    GEM_PACKAGES="linux-headers qt5-qtwebkit-dev"

RUN apk update && \
    apk upgrade && \
    apk add --update --no-cache \
    $BASE_PACKAGES \
    $BUILD_PACKAGES \
    $DEV_PACKAGES \
    $RUBY_PACKAGES \
    $GEM_PACKAGES

RUN wget https://github.com/progrium/entrykit/releases/download/v${ENTRYKIT_VERSION}/entrykit_${ENTRYKIT_VERSION}_Linux_x86_64.tgz \
  && tar -xvzf entrykit_${ENTRYKIT_VERSION}_Linux_x86_64.tgz \
  && rm entrykit_${ENTRYKIT_VERSION}_Linux_x86_64.tgz \
  && mv entrykit /bin/entrykit \
  && chmod +x /bin/entrykit \
  && entrykit --symlink

RUN mkdir -p $APP_ROOT

WORKDIR $APP_ROOT

RUN echo 'gem: --no-document' >> ~/.gemrc && \
    cp ~/.gemrc /etc/gemrc && \
    chmod uog+r /etc/gemrc && \
    bundle config --global build.nokogiri --use-system-libraries

ENV QMAKE=/usr/lib/qt5/bin/qmake

# nginx
ADD nginx.conf /etc/nginx/nginx.conf
ADD adachin.conf /etc/nginx/conf.d/adachin.conf

EXPOSE 3000

# Service to run
COPY ./service.sh /root/
RUN chmod 744 /root/service.sh

CMD ["/root/service.sh"]

