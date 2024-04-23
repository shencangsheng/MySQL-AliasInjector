# MySQL AliasInjector

English | [简体中文](./i18n/README.zh-cn.md)

SQLAliasInjector is a Docker-based tool that enables native compilation of MySQL and allows adding aliases to SQL variables, designed primarily for bypassing SQL Injection checks from firewalls and bastions.

Creation of SQL Variable Aliases: Facilitates to establish custom aliases to replace standard SQL Injection variables, rendering the SQL Injection "invisible" to firewalls and bastions.

## How to use for your

```bash
docker build -t sample/mysql:5.7 --build-arg CP="REGEXP=REGEXP_ALIAS" --build-arg JOB="4" .
```

### Args

| Args | Desc                                         |
| ---- | -------------------------------------------- |
| CP   | that match the specified pattern(「,」split) |
| JOB  | Compile using the number of cores,default: 1 |

## Effect

<p align="center">
<img src="docs/content/assets/img/regexp.alias.png" alt="Regexp" title="Regexp" />
</p>

## License

A short snippet describing the license (MIT)

MIT © Cangsheng Shen
