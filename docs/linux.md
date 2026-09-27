# Linux

Works on Ubuntu, Debian, Fedora, Arch, and other static targets: **linux/amd64** and **linux/arm64**. No extra libraries. No GUI.

## Install

```bash
curl -fsSL https://raw.githubusercontent.com/ethyaan/knowla-cli/main/install.sh | sh
```

## Login, then daemon

```bash
knowla login --api https://sync.knowla.io --token YOUR_TOKEN --folder ~/Vault
knowla install
knowla start
knowla status
```

`knowla run` is foreground. Use `start` / `stop` / `restart` so sync survives a closed terminal.

## Logs

```bash
knowla log-level debug
```

Default: `~/.config/knowla/logs/error-YYYY-MM-DD.log`. See the [README](../README.md#logs).
