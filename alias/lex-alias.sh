#!/bin/bash
# creator by shencangsheng
set -xe

mysql_file=
mysql_lex=
mysql_lex_alias=

while getopts "v:f:c:h" opt; do
    case $opt in
    v)
        mysql_lex_alias=$OPTARG
        ;;
    f)
        mysql_file=$OPTARG
        ;;
    c)
        mysql_lex=$OPTARG
        ;;
    h)
        echo "Add an Alias to Mysql System Lex"
        echo "Usage: bash alias.sh [OPTION...]"
        echo ""
        echo "Examples:"
        echo "bash alias.sh -f ~/mysql-5.7-server -c REGEXP -v REGEXP_ALIAS"
        echo ""
        echo "Main operation mode:"
        echo ""
        echo "-f, # Mysql server source file path [Required]"
        echo "-c, # To be copied mysql system lex [Required]"
        echo "-v, # Mysql system lex alias [Required]"
        exit 0
        ;;
    *)
        echo "there is unrecognized parameter."
        exit 1
        ;;
    esac
done

set -u

if [ ! -d "${mysql_file}" ]; then
    echo "The Mysql file path does not exist"
    exit 1
fi

mysql_lex_file="${mysql_file}/sql/lex.h"

if [ ! -f "${mysql_lex_file}" ]; then
    echo "The Mysql Lex file does not exist"
    exit 1
fi

lex_grep_value=$(grep -n -s "{.*\(\"${mysql_lex}\",.*\)}," ${mysql_lex_file})

lex_line=$(echo ${lex_grep_value} | awk -F ': ' '{print $1}')

lex_value=$(echo ${lex_grep_value} | awk -F ': ' '{print $2}')

sed_value="s/\""${mysql_lex}"\"/\""${mysql_lex_alias}"\"/g"

lex_value_alias=$(echo ${lex_value} | sed ${sed_value})

sed -i "${lex_line}a ${lex_value_alias}" ${mysql_lex_file}
