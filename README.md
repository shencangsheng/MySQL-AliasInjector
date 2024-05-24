# MySQL AliasInjector

English | [简体中文](./i18n/README.zh-cn.md)

SQLAliasInjector is a tool designed to add alias keywords to `SQL` from the `MySQL` source code level and compile a complete running image of `MySQL` in `Docker`. Its primary purpose is to bypass firewall or bastion host `SQL` injection checks, making the `SQL` injection "invisible" to firewalls and bastion hosts.

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
