# Knowla CLI

Folder sync for [Knowla](https://knowla.io). Binaries only. Source is not in this repo.

## Supported systems

| OS | CPU | File |
| --- | --- | --- |
| Linux (Ubuntu, Debian, Fedora, Arch, and similar) | x86_64 | `knowla-*-linux-amd64.tgz` |
| Linux | ARM64 | `knowla-*-linux-arm64.tgz` |
| macOS | Apple Silicon | `knowla-*-darwin-arm64.tgz` |
| macOS | Intel | `knowla-*-darwin-amd64.tgz` |

No extra libraries. Windows is not supported.

## knowla vs knowlad

| Binary | Role |
| --- | --- |
| `knowlad` | Daemon. Watches one folder, talks to the Knowla sync API, listens on `127.0.0.1:18787`. Must stay running or sync stops. |
| `knowla` | CLI. Login, start, status, stop, install. |

You install both. Day to day you type `knowla`.

## Install

```bash
curl -fsSL https://raw.githubusercontent.com/ethyaan/knowla-cli/main/install.sh | sh
```

The script detects OS and CPU, downloads the matching tarball from [Releases](https://github.com/ethyaan/knowla-cli/releases/latest), and copies `knowla` + `knowlad` to `/usr/local/bin` (asks for `sudo` if needed).

Read the script first if you prefer not to pipe to `sh`: [install.sh](install.sh).

## Login

You need an API URL and a bearer token from Knowla.

```bash
knowla login --api https://sync.knowla.io --token YOUR_TOKEN --folder ~/Vault
```

Config is `~/.config/knowla/config.json`. The token stays on your machine.

`knowla run` is **foreground only**. Close the terminal and sync dies. Use the daemon below so it keeps running.

## Run the daemon (required for ongoing sync)

`knowlad` must run in the background. `knowla install` writes the OS service file. Then you enable it.

**Linux (systemd user):**

```bash
knowla install
systemctl --user enable --now knowlad.service
```

If systemd is missing, start `knowlad` yourself and keep that process alive.

**macOS (launchd):**

```bash
knowla install
launchctl bootstrap gui/$(id -u) ~/Library/LaunchAgents/io.knowla.knowlad.plist
launchctl enable gui/$(id -u)/io.knowla.knowlad
```

Check it:

```bash
knowla status
```

Stop the engine (daemon process stays up): `knowla stop`.

## Logs

Default level is **error**. Failed uploads, downloads, and socket failures go to a dated file:

```text
~/.config/knowla/logs/error-2026-09-27.log
```

Each enabled level has its own file. A new file starts each UTC day.

| Level | File | When |
| --- | --- | --- |
| `error` (default) | `error-YYYY-MM-DD.log` | Sync to the server failed, or a local write/read failed |
| `warning` | `warning-YYYY-MM-DD.log` | Conflicts, reconnects, socket-down polling |
| `debug` | `debug-YYYY-MM-DD.log` | Ticks, disk events, socket up |

Enable more (writes that level and everything above it):

```bash
knowla login --api https://sync.knowla.io --token YOUR_TOKEN --folder ~/Vault --log-level warning
```

Or `--log-level debug`. Lines look like `2026-09-27T16:49:00.123Z error upload note.md failed: ...`.

Restart the daemon after changing the level (`systemctl --user restart knowlad.service` or reload the LaunchAgent).

## Docs

- [Linux](docs/linux.md)
- [macOS CLI](docs/darwin.md)

## License

Binaries only. All rights reserved. Source is not published.
