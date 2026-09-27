# macOS CLI

Same `knowla` / `knowlad` as Linux. No menu bar. The Mac app is a separate download.

## Install

```bash
curl -fsSL https://raw.githubusercontent.com/ethyaan/knowla-cli/main/install.sh | sh
```

The script picks `darwin-arm64` or `darwin-amd64` and clears Gatekeeper quarantine. Manual tarball: [Releases](https://github.com/ethyaan/knowla-cli/releases/latest).

## First run

```bash
knowla login --api https://sync.knowla.io --token YOUR_TOKEN --folder ~/Vault
knowla run
```

`knowla install` does not write launchd. Keep `knowla run` in a terminal, or use your own supervisor.
