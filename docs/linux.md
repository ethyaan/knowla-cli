# Linux

Static `knowla` and `knowlad`. No GUI. No extra libraries.

## Install

From [Releases](https://github.com/ethyaan/knowla-cli/releases/latest):

```bash
VERSION=0.1.0
ARCH=$(uname -m)
case "$ARCH" in x86_64) ARCH=amd64 ;; aarch64|arm64) ARCH=arm64 ;; esac

curl -sL "https://github.com/ethyaan/knowla-cli/releases/latest/download/knowla-${VERSION}-linux-${ARCH}.tgz" -o knowla.tgz
tar -xzf knowla.tgz
sudo cp knowla-${VERSION}-linux-${ARCH}/knowla knowla-${VERSION}-linux-${ARCH}/knowlad /usr/local/bin/
```

## First run

```bash
knowla login --api https://sync.knowla.io --token YOUR_TOKEN --folder ~/Vault
knowla run
```

```bash
knowla status
knowla stop
```

## Autostart

```bash
knowla install
systemctl --user enable --now knowlad.service
```

If systemd is missing, run `knowlad` in a terminal or your own supervisor.

Docker is not the Linux product.
