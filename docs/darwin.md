# macOS CLI

Works on **Apple Silicon** (`darwin-arm64`) and **Intel** (`darwin-amd64`). macOS 14+ is the tested line. No extra libraries.

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

`knowla run` is foreground. `start` / `stop` / `restart` drive the LaunchAgent so sync survives closing Terminal.

## Logs

```bash
knowla log-level debug
```

Default: `~/.config/knowla/logs/error-YYYY-MM-DD.log`. See the [README](../README.md#logs).
