#!/usr/bin/env sh
set -eu

# Knowla CLI installer. Review before piping to sh:
#   curl -fsSL https://raw.githubusercontent.com/ethyaan/knowla-cli/main/install.sh | sh
#
# Optional:
#   KNOWLA_VERSION=0.1.0 PREFIX=$HOME/.local/bin sh install.sh

REPO="ethyaan/knowla-cli"
PREFIX="${PREFIX:-/usr/local/bin}"

die() {
  echo "knowla-cli: $*" >&2
  exit 1
}

need() {
  command -v "$1" >/dev/null 2>&1 || die "need $1"
}

need uname
need tar
if command -v curl >/dev/null 2>&1; then
  download() { curl -fsSL "$1" -o "$2"; }
  fetch() { curl -fsSL "$1"; }
elif command -v wget >/dev/null 2>&1; then
  download() { wget -qO "$2" "$1"; }
  fetch() { wget -qO- "$1"; }
else
  die "need curl or wget"
fi

os=$(uname -s | tr '[:upper:]' '[:lower:]')
arch=$(uname -m)
case "$arch" in
  x86_64) arch=amd64 ;;
  aarch64 | arm64) arch=arm64 ;;
  *) die "unsupported cpu: $arch" ;;
esac
case "$os" in
  linux | darwin) ;;
  *) die "unsupported os: $os (linux or macOS only)" ;;
esac

if [ -z "${KNOWLA_VERSION:-}" ]; then
  KNOWLA_VERSION=$(fetch "https://api.github.com/repos/${REPO}/releases/latest" \
    | sed -n 's/.*"tag_name": "v\([^"]*\)".*/\1/p' \
    | head -n 1)
fi
[ -n "$KNOWLA_VERSION" ] || die "could not read latest release"

asset="knowla-${KNOWLA_VERSION}-${os}-${arch}.tgz"
url="https://github.com/${REPO}/releases/download/v${KNOWLA_VERSION}/${asset}"

tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT
echo "downloading $asset"
download "$url" "$tmp/$asset"
tar -xzf "$tmp/$asset" -C "$tmp"
src="$tmp/knowla-${KNOWLA_VERSION}-${os}-${arch}"
[ -x "$src/knowla" ] && [ -x "$src/knowlad" ] || die "tarball missing binaries"

install_bin() {
  dest="$PREFIX"
  if [ -w "$dest" ] 2>/dev/null || mkdir -p "$dest" 2>/dev/null && [ -w "$dest" ]; then
    cp "$src/knowla" "$src/knowlad" "$dest/"
  else
    need sudo
    sudo mkdir -p "$dest"
    sudo cp "$src/knowla" "$src/knowlad" "$dest/"
  fi
  chmod +x "$dest/knowla" "$dest/knowlad" 2>/dev/null \
    || sudo chmod +x "$dest/knowla" "$dest/knowlad"
}

install_bin

if [ "$os" = darwin ]; then
  xattr -cr "$PREFIX/knowla" "$PREFIX/knowlad" 2>/dev/null || true
fi

echo "installed $PREFIX/knowla $PREFIX/knowlad ($os/$arch v$KNOWLA_VERSION)"
echo "next: knowla login --api https://sync.knowla.io --token YOUR_TOKEN --folder ~/Vault"
echo "      knowla run"
