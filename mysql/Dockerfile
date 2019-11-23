FROM mysql:5.7

LABEL maintainer devteam

RUN apt-get update
RUN apt-get install -y --no-install-recommends\
    locales \
    openssh-server \
    python \
    vim \
    && apt-get clean \
    && rm -rf /var/cache/apt/archives/* \
    /var/lib/apt/lists/*

RUN echo "ja_JP.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen ja_JP.UTF-8
ENV LC_ALL ja_JP.UTF-8

# Setup MySQL
RUN touch /var/log/mysqld.log \
    && chown mysql:adm /var/log/mysqld.log

RUN mkdir /var/mysql \
    && chown mysql:adm /var/mysql
COPY ./mysqld.cnf /etc/mysql/mysql.conf.d/

ADD ./mysql_init.sh /tmp/mysql_init.sh
RUN chmod 755 /tmp/mysql_init.sh

COPY ./service.sh /root/
RUN chmod 744 /root/service.sh

# Port to expose *outside* the container
EXPOSE 22
EXPOSE 3306

# Service to run
CMD ["/root/service.sh"]

