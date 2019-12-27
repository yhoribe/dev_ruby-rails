FROM alpine:3.11

LABEL maintainer adachin_devteam

ARG pip_installer="https://bootstrap.pypa.io/get-pip.py"

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
    openssh \
    sudo \
    perl \
    curl \
    curl-dev \
    wget \
    git \
    python \
    curl \
    groff \
    mysql-client \
    bash \
    supervisor \
    vim && \
    rm -rf /var/cache/apk/*

# Install awscli
RUN curl ${pip_installer} | python && \
    pip install awscli

# Create adachin user
RUN apk add sudo
RUN adduser -D adachin
RUN sed -ri 's/^wheel:x:10:/wheel:x:10:adachin/' /etc/group
RUN sed -ri 's/^# %wheel/adachin/' /etc/sudoers
RUN sed -ri '85 s/adachin/#adachin/' /etc/sudoers
COPY common/shadow /etc/
COPY .vimrc /root/
COPY .vimrc /home/adachin/
RUN echo Set disable_coredump false > /etc/sudo.conf

# Setup ssh
RUN sed -ri 's/^#Port 22/Port 2222/' /etc/ssh/sshd_config
RUN sed -ri 's/^#PermitEmptyPasswords no/PermitEmptyPasswords yes/' /etc/ssh/sshd_config
RUN sed -ri 's/^#PermitRootLogin yes/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/^UsePAM yes/UsePAM no/' /etc/ssh/sshd_config
RUN sed -ri 's/^#PermitUserEnvironment no/PermitUserEnvironment no/' /etc/ssh/sshd_config
RUN ssh-keygen -A

# setting superviser
COPY supervisor/sshd.conf /etc/supervisor/conf.d/sshd.conf
RUN echo files = /etc/supervisor/conf.d/*.conf >> /etc/supervisord.conf

# Service to run
CMD [ "/usr/bin/supervisord" ]

