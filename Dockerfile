FROM shencangsheng/mysql-source-compile:latest as compile

ARG MYSQL_INPUT_FILE=mysql-server-5.7

COPY ${MYSQL_INPUT_FILE} ${MYSQL_FILE}

RUN compile-mysql

FROM debian:buster-slim as compile-builder

COPY --from=compile /usr/local/mysql /usr/local/mysql

COPY mysqld.cnf /etc/my.cnf

RUN groupadd mysql \
    && useradd -r -g mysql mysql \
    && mkdir -p /var/lib/mysql \
    && chown -R mysql:mysql /usr/local/mysql \
    && chown -R mysql:mysql /var/lib/mysql

RUN ./bin/mysqld --initialize-insecure --user=mysql --basedir=/usr/local/mysql --datadir=/var/lib/mysql \
    && ./bin/mysql_ssl_rsa_setup

RUN mkdir -p /var/run/mysqld \
    && chown -R mysql:mysql /var/run/mysqld

RUN cp support-files/mysql.server /etc/init.d/mysqld

COPY docker-entrypoint.sh /usr/local/bin/

RUN ln -s usr/local/bin/docker-entrypoint.sh /entrypoint.sh # backwards compat

ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 3306 33060

CMD ["mysqld"]

FROM debian:buster-slim as copy-builder

COPY output/mysql.tar.gz /

RUN tar -zxf /mysql.tar.gz -C /usr/local mysql

COPY mysqld.cnf /etc/my.cnf

RUN groupadd mysql \
    && useradd -r -g mysql mysql \
    && mkdir -p /var/lib/mysql \
    && chown -R mysql:mysql /usr/local/mysql \
    && chown -R mysql:mysql /var/lib/mysql

RUN ./bin/mysqld --initialize-insecure --user=mysql --basedir=/usr/local/mysql --datadir=/var/lib/mysql \
    && ./bin/mysql_ssl_rsa_setup

RUN mkdir -p /var/run/mysqld \
    && chown -R mysql:mysql /var/run/mysqld

RUN cp support-files/mysql.server /etc/init.d/mysqld

COPY docker-entrypoint.sh /usr/local/bin/

RUN ln -s usr/local/bin/docker-entrypoint.sh /entrypoint.sh # backwards compat

ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 3306 33060

CMD ["mysqld"]