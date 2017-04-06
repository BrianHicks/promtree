#!/usr/bin/env bash
set -euo pipefail

tmp=$(mktemp -d)
metrics=${1:-localhost:8991/metrics}

cleanup() {
	rm -rf "$tmp"
}
trap cleanup EXIT

for path in $(curl -s "$metrics" | grep -ve '^#' | cut -f1 -d' ' | tr '_' '/'); do
    mkdir -p "$tmp"/"$path"
done

cd "$tmp"
tree
