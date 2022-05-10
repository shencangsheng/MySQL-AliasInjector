# Mysql System Lex Alias

[English](https://github.com/shencangsheng/Mysql-System-Lex-Alias) | 简体中文

在 Mysql 中添加一个系统关键词别名

[DockerHub Repositorie](https://hub.docker.com/r/shencangsheng/mysql-system-lex-alias)

- [Mysql System Lex Alias](#mysql-system-lex-alias)
  - [如何使用](#如何使用)
    - [下载 MYSQL 源码](#下载-mysql-源码)
    - [添加一个系统关键词别名](#添加一个系统关键词别名)
    - [编译源代码](#编译源代码)
  - [License](#license)

## 如何使用

### 下载 MYSQL 源码

```bash
wget https://codeload.github.com/mysql/mysql-server/zip/refs/heads/5.7
unzip mysql-server-5.7.zip
```

### 添加一个系统关键词别名

```bash
docker run --rm -v $(pwd)/mysql-server-5.7:/mysql-server-5.7 shencangsheng/mysql-system-lex-alias add-lex-alias -v 5.7 -f /mysql-server-5.7 -c REGEXP -a REGEXP_ALIAS
```

### 编译源代码

- 基于多层构建编译，性能极佳 **[推荐]**

```bash
docker build --target compile --target compile-builder -t ${username}/mysql:latest .
```

- 基于挂载形式编译, 编译缓慢, 并输出压缩文件 **[不推荐]**

```bash
docker run --rm -v $(pwd)/mysql-server-5.7:/usr/local/mysql-server -v $(pwd)/output:/output shencangsheng/mysql-source-compile:latest package-mysql
docker build --target copy-builder -t ${username}/mysql:latest .
```

## License

A short snippet describing the license (MIT)

MIT © Cangsheng Shen