#!/usr/bin/env bash
set -euo pipefail

# abort if REMOTE_PATH is unset or empty
: "${REMOTE_PATH:?REMOTE_PATH must be set}"

REMOTE="$HOME/${REMOTE_PATH}"

# refuse to delete HOME itself
if [ "$REMOTE" = "$HOME" ]; then
  echo "Refusing to rm -rf home directory!" >&2
  exit 1
fi

# remove only the *contents* of REMOTE, not the directory itself
rm -rf "${REMOTE:?}/"*
mkdir -p "$REMOTE"

# ─── Unpack new build ────────────────────────────
tar xzf /home/remix-build.tar.gz -C "$REMOTE"
rm /home/remix-build.tar.gz

cd "$REMOTE"

# ─── Install production deps ─────────────────────
npm ci --omit=dev

# ─── Reload or start via PM2 ──────────────────────
pm2 reload ecosystem.config.cjs --env production --only nf010-nifl-website-ui \
  || pm2 start ecosystem.config.cjs --env production --only nf010-nifl-website-ui

# ─── Persist across reboots ───────────────────────
pm2 save

