FROM ubuntu:16.04

ARG MYSQL_FILE=/usr/local/mysql-server

RUN apt update

RUN apt-get install cmake bison libncurses5-dev wget build-essential libssl-dev pkg-config -y

RUN wget https://sourceforge.net/projects/boost/files/boost/1.59.0/boost_1_59_0.tar.gz \
    && tar -zxvf boost_1_59_0.tar.gz -C /usr/local/ \
    && rm -f boost_1_59_0.tar.gz

COPY compile.sh /usr/local/bin/compile-mysql

COPY package.sh /usr/local/bin/package-mysql

RUN chmod -R 755 /usr/local/bin/*

RUN mkdir /output

ENV MYSQL_PATH ${MYSQL_FILE}