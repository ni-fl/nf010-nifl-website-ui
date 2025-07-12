#!/usr/bin/env bash
set -e

# (we'll pass REMOTE_PATH in as an env var)
REMOTE="$HOME/${REMOTE_PATH}"

if [ -d "$REMOTE" ]; then
  sudo chown -R "$(whoami):$(whoami)" "$REMOTE"
fi

# ─── Clean old release ───────────────────────────
rm -rf "$REMOTE"
mkdir -p "$REMOTE"

# ─── Unpack new build ────────────────────────────
tar xzf ~/remix-build.tar.gz -C "$REMOTE"
rm ~/remix-build.tar.gz

cd "$REMOTE"

# ─── Install production deps ─────────────────────
npm ci --omit=dev

# ─── Reload or start via PM2 ──────────────────────
pm2 reload ecosystem.config.cjs --env production --only nf010-nifl-website-ui \
  || pm2 start ecosystem.config.cjs --env production --only nf010-nifl-website-ui

# ─── Persist across reboots ───────────────────────
pm2 save

