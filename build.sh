#!/usr/bin/env bash
set -euo pipefail

HUGO_VERSION="0.165.0"

tmp_dir=$(mktemp -d)
trap 'rm -rf "$tmp_dir"' EXIT

echo "Installing Hugo ${HUGO_VERSION}..."

curl -sfL \
  -o "${tmp_dir}/hugo.tar.gz" \
  "https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_${HUGO_VERSION}_linux-amd64.tar.gz"

mkdir -p "${HOME}/.local/hugo"

tar \
  -C "${HOME}/.local/hugo" \
  -xf "${tmp_dir}/hugo.tar.gz"

export PATH="${HOME}/.local/hugo:${PATH}"

echo "Using $(hugo version)"

if [[ -f .gitmodules ]]; then
  git submodule update --init --recursive
fi

hugo --gc --minify