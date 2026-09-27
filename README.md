# Knowla CLI

Folder sync for [Knowla](https://knowla.io). Binaries only. Source is not in this repo.

This is not the menu-bar Mac app. This is not a self-hosted server.

## knowla vs knowlad

| Binary | Role |
| --- | --- |
| `knowlad` | Daemon. Watches one folder, talks to the Knowla sync API, listens on `127.0.0.1:18787`. |
| `knowla` | CLI. Login, start, status, stop. `knowla run` is the daemon in the foreground if nothing is already listening. |

You install both. Day to day you type `knowla`.

## Install

Pick the tarball for your OS and CPU from [Releases](https://github.com/ethyaan/knowla-cli/releases/latest).

| File | Who |
| --- | --- |
| `knowla-0.1.0-linux-amd64.tgz` | Linux x86_64 |
| `knowla-0.1.0-linux-arm64.tgz` | Linux ARM64 |
| `knowla-0.1.0-darwin-arm64.tgz` | Apple Silicon |
| `knowla-0.1.0-darwin-amd64.tgz` | Intel Mac |

```bash
VERSION=0.1.0
OS=$(uname -s | tr '[:upper:]' '[:lower:]')
ARCH=$(uname -m)
case "$ARCH" in x86_64) ARCH=amd64 ;; aarch64|arm64) ARCH=arm64 ;; esac

curl -sL "https://github.com/ethyaan/knowla-cli/releases/latest/download/knowla-${VERSION}-${OS}-${ARCH}.tgz" -o knowla.tgz
tar -xzf knowla.tgz
sudo cp knowla-${VERSION}-${OS}-${ARCH}/knowla knowla-${VERSION}-${OS}-${ARCH}/knowlad /usr/local/bin/
```

No extra libraries. Ubuntu, Debian, Fedora, Arch, and macOS work with the binary alone.

## First run

You need an API URL and a bearer token from Knowla.

```bash
knowla login --api https://sync.knowla.io --token YOUR_TOKEN --folder ~/Vault
knowla run
```

`run` stays in the foreground. Idle unless a file changes or the API wakes the socket.

```bash
knowla status
knowla stop
```

Config is `~/.config/knowla/config.json`. The token stays on your machine.

## Autostart

**Linux (systemd user):**

```bash
knowla install
systemctl --user enable --now knowlad.service
```

If systemd is missing, `install` does nothing useful — run `knowlad` yourself.

**macOS:** `knowla install` does not write launchd. Run `knowla run` in a terminal, or use your own supervisor.

## Docs

- [Linux](docs/linux.md)
- [macOS CLI](docs/darwin.md)

## License

Binaries only. All rights reserved. Source is not published.
