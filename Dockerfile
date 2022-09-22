FROM shencangsheng/mysql-source-compile:latest as compile

ARG MYSQL_INPUT_FILE=mysql-server-5.7

COPY ${MYSQL_INPUT_FILE} ${MYSQL_PATH}

RUN compile-mysql

FROM debian:buster-slim as compile-builder

RUN apt update && apt install -y openssl libatomic1 libncurses5 gosu

COPY --from=compile /usr/local/mysql /usr/local/mysql

RUN mkdir -p /etc/mysql/conf.d && echo '[mysqld]\nskip-host-cache\nskip-name-resolve' > /etc/mysql/conf.d/docker.cnf

RUN groupadd mysql \
    && useradd -r -g mysql mysql \
    && mkdir -p /var/lib/mysql \
    && chown -R mysql:mysql /usr/local/mysql \
    && chown -R mysql:mysql /var/lib/mysql

WORKDIR /usr/local/mysql

RUN ./bin/mysqld --initialize-insecure --user=mysql --basedir=/usr/local/mysql --datadir=/var/lib/mysql \
    && ./bin/mysql_ssl_rsa_setup

RUN rm -rf /var/lib/mysql && mkdir -p /var/lib/mysql /var/run/mysqld \
    && chown -R mysql:mysql /var/run/mysqld \
    && chmod 1777 /var/run/mysqld /var/lib/mysql

RUN mkdir /docker-entrypoint-initdb.d

RUN cp support-files/mysql.server /etc/init.d/mysqld

VOLUME /var/lib/mysql

COPY docker-entrypoint.sh /usr/local/bin/

ENV PATH "/usr/local/mysql/bin:${PATH}"

RUN ln -s /usr/local/bin/docker-entrypoint.sh /entrypoint.sh # backwards compat

ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 3306 33060

RUN rm -rf /var/lib/apt/lists/*

CMD ["mysqld"]

FROM debian:buster-slim as copy-builder

RUN apt update && apt install -y openssl libatomic1 libncurses5 gosu

COPY output/mysql.tar.gz /

RUN tar -zxf /mysql.tar.gz -C /usr/local mysql

RUN mkdir -p /etc/mysql/conf.d && echo '[mysqld]\nskip-host-cache\nskip-name-resolve' > /etc/mysql/conf.d/docker.cnf

RUN groupadd mysql \
    && useradd -r -g mysql mysql \
    && mkdir -p /var/lib/mysql \
    && chown -R mysql:mysql /usr/local/mysql \
    && chown -R mysql:mysql /var/lib/mysql

WORKDIR /usr/local/mysql

RUN ./bin/mysqld --initialize-insecure --user=mysql --basedir=/usr/local/mysql --datadir=/var/lib/mysql \
    && ./bin/mysql_ssl_rsa_setup

RUN rm -rf /var/lib/mysql && mkdir -p /var/lib/mysql /var/run/mysqld \
    && chown -R mysql:mysql /var/run/mysqld \
    && chmod 1777 /var/run/mysqld /var/lib/mysql

RUN mkdir /docker-entrypoint-initdb.d

RUN cp support-files/mysql.server /etc/init.d/mysqld

VOLUME /var/lib/mysql

COPY docker-entrypoint.sh /usr/local/bin/

ENV PATH "/usr/local/mysql/bin:${PATH}"

RUN ln -s /usr/local/bin/docker-entrypoint.sh /entrypoint.sh # backwards compat

ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 3306 33060

RUN rm -rf /var/lib/apt/lists/*

CMD ["mysqld"]