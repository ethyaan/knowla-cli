# Linux

Static `knowla` and `knowlad`. No GUI. No extra libraries.

## Install

```bash
curl -fsSL https://raw.githubusercontent.com/ethyaan/knowla-cli/main/install.sh | sh
```

Manual tarball: [Releases](https://github.com/ethyaan/knowla-cli/releases/latest), then copy `knowla` and `knowlad` to `/usr/local/bin`.

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
