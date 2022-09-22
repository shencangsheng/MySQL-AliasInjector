FROM debian:stretch-slim

ARG MYSQL_FILE=/usr/local/mysql-server

ARG POSTTION

RUN if [[ "${POSTTION}" = "CN" ]] ; then \
    echo "deb https://mirrors.tuna.tsinghua.edu.cn/debian/ stretch main contrib non-free" > /etc/apt/sources.list; \
    echo "deb https://mirrors.tuna.tsinghua.edu.cn/debian/ stretch-updates main contrib non-free" >> /etc/apt/sources.list; \
    echo "deb https://mirrors.tuna.tsinghua.edu.cn/debian/ stretch-backports main contrib non-free" >> /etc/apt/sources.list; \
    echo "deb https://mirrors.tuna.tsinghua.edu.cn/debian-security stretch/updates main contrib non-free" >> /etc/apt/sources.list; \
    fi

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

RUN rm -rf /var/lib/apt/lists/*