#!/bin/bash

cd ${MYSQL_PATH}

make clean

rm CMakeCache.txt

cmake . -DCMAKE_INSTALL_PREFIX=/usr/local/mysql -DMYSQL_DATADIR=/var/lib/mysql -DWITH_BOOST=/usr/local/boost_1_59_0 -DSYSCONFDIR=/etc -DEXTRA_CHARSETS=all

make

make install
