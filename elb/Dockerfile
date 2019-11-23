FROM alpine:3.9

LABEL maintainer devteam

# Setup UTC+9
RUN apk --update add tzdata && \
    cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime && \
    apk del tzdata

# Install Package
RUN apk update && \
    apk upgrade && \
    apk add --update \
    bash \
    openssl \
    openssl-dev \
    perl \
    curl \
    curl-dev \
    vim && \
    rm -rf /var/cache/apk/*

COPY .vimrc /root/
COPY .vimrc /home/lancers/

# Setup h2o
RUN apk add h2o
RUN mkdir -p /etc/h2o/conf.d

COPY ./h2o/h2o.conf      /etc/h2o/
COPY ./h2o/conf.d/*      /etc/h2o/conf.d/
#COPY ./sslcert/*.crt     /etc/pki/tls/certs/
#COPY ./sslcert/*.key     /etc/pki/tls/private/

COPY ./service.sh /root/
RUN chmod 744 /root/service.sh

# Service to run
CMD ["/root/service.sh"]

