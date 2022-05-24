# Mysql System Lex Alias

[English](https://github.com/shencangsheng/Mysql-System-Lex-Alias) | 简体中文

给你的 Mysql 系统保留字段添加一个别名

[DockerHub Repositorie](https://hub.docker.com/r/shencangsheng/mysql-system-lex-alias)

- [Mysql System Lex Alias](#mysql-system-lex-alias)
  - [如何使用](#如何使用)
    - [下载 MYSQL 源码](#下载-mysql-源码)
    - [添加一个系统关键词别名](#添加一个系统关键词别名)
    - [编译源代码](#编译源代码)
    - [效果](#效果)
  - [License](#license)

## 如何使用

### 下载 MYSQL 源码

```bash
wget https://codeload.github.com/mysql/mysql-server/zip/refs/heads/5.7
unzip 5.7
```

### 添加一个系统关键词别名

```bash
docker run --rm -v $(pwd)/mysql-server-5.7:/mysql-server-5.7 shencangsheng/mysql-system-lex-alias:latest add-lex-alias -f /mysql-server-5.7 -c REGEXP -v REGEXP_ALIAS
```

### 编译源代码

- **[ 推荐 ]** 基于多层构建编译，性能极佳

```bash
docker build --target compile --target compile-builder -t ${username}/mysql:latest .
```

- **[ 不推荐 ]** 基于挂载形式编译, 编译缓慢, 并输出压缩文件

```bash
docker run --rm -v $(pwd)/mysql-server-5.7:/usr/local/mysql-server -v $(pwd)/output:/output shencangsheng/mysql-source-compile:latest package-mysql
docker build --target copy-builder -t ${username}/mysql:latest .
```

### 效果

<p align="center">
<img src="../docs/content/assets/img/regexp.alias.png" alt="Regexp" title="Regexp" />
</p>

## License

A short snippet describing the license (MIT)

MIT © Cangsheng Shen
