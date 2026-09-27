# Linux

Works on Ubuntu, Debian, Fedora, Arch, and other glibc/musl-free static targets: **linux/amd64** and **linux/arm64**. No extra libraries. No GUI.

## Install

```bash
curl -fsSL https://raw.githubusercontent.com/ethyaan/knowla-cli/main/install.sh | sh
```

## Login, then daemon

`knowla run` is foreground. For sync to stay up after you close the terminal:

```bash
knowla login --api https://sync.knowla.io --token YOUR_TOKEN --folder ~/Vault
knowla install
systemctl --user enable --now knowlad.service
knowla status
```

If systemd is missing, run `knowlad` and keep that process alive.

## Logs

Default: `~/.config/knowla/logs/error-YYYY-MM-DD.log`. Raise with `--log-level warning` or `debug` on `knowla login`. See the [README](../README.md#logs).
