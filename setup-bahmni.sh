#!/bin/bash
set -euo pipefail

# --- helpers ---
compose() {
  if command -v docker >/dev/null 2>&1 && docker compose version >/dev/null 2>&1; then
    docker compose "$@"
  elif command -v docker-compose >/dev/null 2>&1; then
    docker-compose "$@"
  else
    echo "❌ Neither 'docker compose' nor 'docker-compose' found." >&2
    exit 1
  fi
}

# --- paths ---
BASE="$HOME/Projects"
DEST="$BASE/ATISHEALTH"
PINOTECH_REPO_URL="https://github.com/roymalto/pinotech-base-build.git"
PINOTECH_DIR="$BASE/pinotech-base-build"

BAHMNI_REPO_URL="https://github.com/Bahmni/bahmni-docker.git"
BAHMNI_DIR="$DEST/bahmni-docker"
BAHMNI_STD="$BAHMNI_DIR/bahmni-standard"

CUSTOM_BRANDING_DIR="$DEST/custom-branding"
SRC_COMPOSE="$CUSTOM_BRANDING_DIR/docker-compose.yml"
SRC_ENV="$CUSTOM_BRANDING_DIR/.env"

echo "➡️  Working in: $BASE"
mkdir -p "$BASE"
cd "$BASE"

# --- clone or update pinotech-base-build ---
if [ -d "$PINOTECH_DIR/.git" ]; then
  echo "🔄 Updating pinotech-base-build..."
  git -C "$PINOTECH_DIR" pull --ff-only
elif [ -d "$PINOTECH_DIR" ]; then
  echo "ℹ️  $PINOTECH_DIR exists but is not a git repo. Proceeding to use its contents."
else
  echo "📥 Cloning pinotech-base-build..."
  git clone "$PINOTECH_REPO_URL" "$PINOTECH_DIR"
fi

# --- ensure destination exists ---
mkdir -p "$DEST"

# --- move contents safely (including hidden files) ---
echo "📦 Moving pinotech-base-build contents to $DEST ..."
# Use rsync to include hidden files and preserve attrs; then remove source
if command -v rsync >/dev/null 2>&1; then
  rsync -a "$PINOTECH_DIR"/ "$DEST"/
  rm -rf "$PINOTECH_DIR"
else
  # fallback without rsync
  shopt -s dotglob nullglob
  mv "$PINOTECH_DIR"/* "$DEST"/ || true
  rmdir "$PINOTECH_DIR" 2>/dev/null || rm -rf "$PINOTECH_DIR"
  shopt -u dotglob nullglob
fi

# --- inside ATISHEALTH now ---
cd "$DEST"
echo "📂 Now in: $(pwd)"

# --- clone or update bahmni-docker ---
if [ -d "$BAHMNI_DIR/.git" ]; then
  echo "🔄 Updating bahmni-docker..."
  git -C "$BAHMNI_DIR" pull --ff-only
elif [ -d "$BAHMNI_DIR" ]; then
  echo "ℹ️  $BAHMNI_DIR exists but is not a git repo. Using as-is."
else
  echo "📥 Cloning bahmni-docker..."
  git clone "$BAH MNI_REPO_URL" "$BAHMNI_DIR"
fi

# --- ensure bahmni-standard exists ---
mkdir -p "$BAHMNI_STD"

# --- copy compose + env from custom-branding into bahmni-standard ---
echo "🧩 Copying docker-compose.yml and .env into bahmni-standard..."
if [ -f "$SRC_COMPOSE" ]; then
  cp "$SRC_COMPOSE" "$BAHMNI_STD/"
else
  echo "⚠️  $SRC_COMPOSE not found."
fi

if [ -f "$SRC_ENV" ]; then
  cp "$SRC_ENV" "$BAHMNI_STD/.env"
else
  echo "⚠️  $SRC_ENV not found."
fi

# --- bring up the stack ---
echo "🚀 Starting Bahmni stack..."
cd "$BAHMNI_STD"
compose up -d

echo "✅ Done. Bahmni is starting using:"
echo "   - Compose: $BAHMNI_STD/docker-compose.yml"
echo "   - Env:     $BAHMNI_STD/.env"
