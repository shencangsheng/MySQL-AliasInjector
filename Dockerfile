FROM --platform=amd64 debian:buster-slim as build

SHELL ["/bin/bash", "-c"]

ARG CP

ARG JOB=1

RUN apt update \
    && apt-get install --no-install-recommends binutils wget cmake bison libncurses5-dev wget build-essential libssl-dev pkg-config unzip libaio-dev -y

COPY mysql-cli /usr/local/bin/

RUN chmod +x /usr/local/bin/mysql-cli

RUN mysql-cli --action="cp" --cp="${CP}"

WORKDIR /tmp/

RUN wget --tries=5 --no-check-certificate https://sourceforge.net/projects/boost/files/boost/1.59.0/boost_1_59_0.tar.gz \
    && tar -zxvf boost_1_59_0.tar.gz -C /usr/local/ \
    && rm -f boost_1_59_0.tar.gz

RUN mysql-cli --action="build" --job="$JOB"

WORKDIR /usr/local/mysql

RUN find . -type f -executable -exec strip --strip-all {} \;

RUN groupadd mysql \
    && useradd -r -g mysql mysql \
    && chown -R mysql:mysql /usr/local/mysql

FROM --platform=amd64 debian:buster-slim

COPY --from=build /usr/local/mysql /usr/local/mysql

RUN apt update && apt install --no-install-recommends openssl libatomic1 libncurses5 gosu libaio-dev -y

RUN mkdir -p /etc/mysql/conf.d && echo '[mysqld]\nskip-host-cache\nskip-name-resolve' > /etc/mysql/conf.d/docker.cnf

RUN groupadd mysql \
    && useradd -r -g mysql mysql \
    && mkdir -p /var/lib/mysql \
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

RUN apt clean && rm -rf /var/lib/apt/lists/*