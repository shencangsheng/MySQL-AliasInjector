# Mysql System Lex Alias

English | [简体中文](./i18n/README.zh-cn.md)

Add an Alias to Mysql System Lex

[DockerHub Repositorie](https://hub.docker.com/r/shencangsheng/mysql-system-lex-alias)

- [Mysql System Lex Alias](#mysql-system-lex-alias)
  - [How to use for your](#how-to-use-for-your)
    - [Download Mysql Server Source Code](#download-mysql-server-source-code)
    - [Add an Alias to Mysql System Lex](#add-an-alias-to-mysql-system-lex)
    - [Compile Mysql Server Source Code](#compile-mysql-server-source-code)
  - [License](#license)

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

### Compile Mysql Server Source Code

- Build based on multiple segments, quickly. **[advice]**

```
docker build --target compile --target compile-builder -t ${username}/mysql:latest .
```

- Based on the mount, Compile the slow, Output compression package. **[deprecated]**

```bash
docker run --rm -v $(pwd)/mysql-server-5.7:/usr/local/mysql-server -v $(pwd)/output:/output shencangsheng/mysql-source-compile:latest package-mysql
docker build --target copy-builder -t ${username}/mysql:latest .
```

## License

A short snippet describing the license (MIT)

MIT © Cangsheng Shen
