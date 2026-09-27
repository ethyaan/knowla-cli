# macOS CLI

Works on **Apple Silicon** (`darwin-arm64`) and **Intel** (`darwin-amd64`). macOS 14+ is the tested line. No extra libraries.

## Install

```bash
curl -fsSL https://raw.githubusercontent.com/ethyaan/knowla-cli/main/install.sh | sh
```

The script picks the CPU and clears Gatekeeper quarantine.

## Login, then daemon

`knowla run` is foreground. Close Terminal and sync stops. Keep `knowlad` running with launchd:

```bash
knowla login --api https://sync.knowla.io --token YOUR_TOKEN --folder ~/Vault
knowla install
launchctl bootstrap gui/$(id -u) ~/Library/LaunchAgents/io.knowla.knowlad.plist
launchctl enable gui/$(id -u)/io.knowla.knowlad
knowla status
```

## Logs

Default: `~/.config/knowla/logs/error-YYYY-MM-DD.log`. Raise with `--log-level warning` or `debug` on `knowla login`. See the [README](../README.md#logs).
