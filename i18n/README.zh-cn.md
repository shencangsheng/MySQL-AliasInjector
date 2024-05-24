# MySQL AliasInjector

[English](https://github.com/shencangsheng/MySQL-AliasInjector) | 简体中文

SQLAliasInjector 是一个从 `MySQL` 源码级别添加 `SQL` 的关键字别名的工具，并完整编译 `Docker` 的 `MySQL` 运行镜像，主要用于绕过防火墙或堡垒机的 `SQL` 注入检查，使得 `SQL` 注入在防火墙和堡垒机前“隐身”。

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
