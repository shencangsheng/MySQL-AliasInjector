FROM alpine:3.15.0

ARG POSTTION

RUN if [[ "${POSTTION}" = "CN" ]] ; then \
    sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories ; \
    fi

RUN apk update \
    && apk upgrade \
    && apk add --no-cache bash

RUN rm -rf /var/cache/apk/* \
    && /bin/bash

COPY lex-alias.sh /usr/local/bin/add-lex-alias

RUN chmod -R 755 /usr/local/bin/*