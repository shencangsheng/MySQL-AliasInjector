# MySQL AliasInjector

[English](https://github.com/shencangsheng/MySQL-AliaInjector) | 简体中文

SQLAliasInjector 是一款基于 Docker 的源生编译 MySQL 并添加一个 SQL 变量的别名工具，主要用于绕过防火墙或堡垒机的 SQL 注入检查。

创建 SQL 变量别名：设置自定义别名以替代标准的 SQL 注入变量，使得 SQL 注入在防火墙和堡垒机前“隐身”。

## 如何使用

```bash
docker build -t sample/mysql:5.7 --build-arg CP="REGEXP=REGEXP_ALIAS" --build-arg JOB="4" .
```

### Args

| Args | Desc                           |
| ---- | ------------------------------ |
| CP   | 使用「,」分隔多个              |
| JOB  | 编译时使用的核心数，default: 1 |

## 效果

<p align="center">
<img src="../docs/content/assets/img/regexp.alias.png" alt="Regexp" title="Regexp" />
</p>

## License

A short snippet describing the license (MIT)

MIT © Cangsheng Shen
