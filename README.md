# Mysql-System-Lex-Alias

English | [简体中文](./i18n/README.zh-cn.md)

Add an Alias to Mysql System Lex

[DockerHub Repositorie](https://hub.docker.com/r/shencangsheng/mysql-system-lex-alias)

## How to use for your

### Download Mysql Server Source Code

```bash
wget https://codeload.github.com/mysql/mysql-server/zip/refs/heads/5.7
unzip mysql-server-5.7.zip
```

### Add an Alias to Mysql System Lex

```
docker run --rm -v $(pwd)/mysql-server-5.7:/mysql-server-5.7 shencangsheng/mysql-system-lex-alias add-lex-alias -v 5.7 -f /mysql-server-5.7 -c REGEXP -a REGEXP_ALIAS
```
