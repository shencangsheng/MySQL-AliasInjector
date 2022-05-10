#!/bin/bash

compile-mysql

tar –czf /output/mysql.tar.gz -C /usr/local mysql
