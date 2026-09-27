# macOS CLI

Same `knowla` / `knowlad` as Linux. No menu bar. The Mac app is a separate download.

## Install

Apple Silicon:

```bash
VERSION=0.1.0
curl -sL "https://github.com/ethyaan/knowla-cli/releases/latest/download/knowla-${VERSION}-darwin-arm64.tgz" -o knowla.tgz
tar -xzf knowla.tgz
sudo cp knowla-${VERSION}-darwin-arm64/knowla knowla-${VERSION}-darwin-arm64/knowlad /usr/local/bin/
```

Intel Mac: use `darwin-amd64`.

Gatekeeper may block an unsigned binary. Right-click the binary → Open once, or:

```bash
xattr -cr /usr/local/bin/knowla /usr/local/bin/knowlad
```

## First run

```bash
knowla login --api https://sync.knowla.io --token YOUR_TOKEN --folder ~/Vault
knowla run
```

`knowla install` does not write launchd. Keep `knowla run` in a terminal, or use your own supervisor.
