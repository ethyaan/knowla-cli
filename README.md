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

```bash
curl -fsSL https://raw.githubusercontent.com/ethyaan/knowla-cli/main/install.sh | sh
```

That script detects Linux vs macOS and Intel vs ARM, downloads the matching tarball from [Releases](https://github.com/ethyaan/knowla-cli/releases/latest), and copies `knowla` + `knowlad` to `/usr/local/bin` (asks for `sudo` if that folder is not writable). No extra libraries.

Read the script first if you prefer not to pipe to `sh`: [install.sh](install.sh). Manual tarball steps are in [docs/linux.md](docs/linux.md) and [docs/darwin.md](docs/darwin.md).

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
