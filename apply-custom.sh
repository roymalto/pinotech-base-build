#!/bin/bash
set -euo pipefail

echo "🔧 Applying Pinotech EMR branding..."

# --- Locate Bahmni web container ---
WEB_CONTAINER=$(docker ps --filter "name=bahmni-web" --format "{{.Names}}")
if [ -z "$WEB_CONTAINER" ]; then
  echo "❌ Bahmni web container not found (name like *bahmni-web*)."
  exit 1
fi
echo "🐳 Target container: $WEB_CONTAINER"

# --- Helper to copy if present ---
copy_if_exists () {
  local src="$1"
  local dst="$2"
  if [ -f "$src" ]; then
    docker cp "$src" "$WEB_CONTAINER:$dst"
    echo "📦 Copied $(basename "$src") → $dst"
  else
    echo "⚠️  Skipped (not found): $src"
  fi
}

echo "📂 Copying branding files..."
copy_if_exists custom-branding/logo.png               /usr/local/apache2/htdocs/bahmni/home/logo.png
copy_if_exists custom-branding/logo.png               /usr/local/apache2/htdocs/bahmni_config/openmrs/apps/home/logo.png
copy_if_exists custom-branding/bahmniLogoFull.png     /usr/local/apache2/htdocs/bahmni/images/bahmniLogoFull.png
copy_if_exists custom-branding/favicon.ico            /usr/local/apache2/htdocs/bahmni/home/favicon.ico
copy_if_exists custom-branding/bahmni-logo.png        /usr/local/apache2/htdocs/bahmni-logo.png
copy_if_exists custom-branding/favicon.ico            /usr/local/apache2/htdocs/bahmni/favicon.ico
copy_if_exists custom-branding/logo.png               /usr/local/apache2/htdocs/bahmni/logo.png
copy_if_exists custom-branding/analytics.png          /usr/local/apache2/htdocs/bahmni/images/analytics.png
copy_if_exists custom-branding/app.png                /usr/local/apache2/htdocs/bahmni/images/app.png
copy_if_exists custom-branding/bahmniLogo.png         /usr/local/apache2/htdocs/bahmni/images/bahmniLogo.png
copy_if_exists custom-branding/lab.png                /usr/local/apache2/htdocs/bahmni/images/lab.png
copy_if_exists custom-branding/bills.png              /usr/local/apache2/htdocs/bahmni/images/bills.png
copy_if_exists custom-branding/connect.png            /usr/local/apache2/htdocs/bahmni/images/connect.png
copy_if_exists custom-branding/pac.png                /usr/local/apache2/htdocs/bahmni/images/pac.png

echo "🧩 Copying localization & config..."
copy_if_exists custom-branding/locale_en.json           /usr/local/apache2/htdocs/bahmni_config/openmrs/apps/home/locale_en.json
copy_if_exists custom-branding/whiteLabel.json          /usr/local/apache2/htdocs/bahmni_config/openmrs/apps/home/whiteLabel.json
copy_if_exists custom-branding/app.json                 /usr/local/apache2/htdocs/bahmni_config/openmrs/apps/home/app.json
copy_if_exists custom-branding/apps.json                /usr/local/apache2/htdocs/bahmni_config/openmrs/apps.json
copy_if_exists custom-branding/registration/apps.json   /usr/local/apache2/htdocs/bahmni_config/openmrs/apps/registration/apps.json

echo "✏️  Updating HTML title and auto-detecting JS bundles..."
docker exec "$WEB_CONTAINER" sh -lc '
set -e
HTML_DIR="/usr/local/apache2/htdocs/bahmni/home"

# 1) Update <title> in index.html if present
if [ -f "$HTML_DIR/index.html" ]; then
  sed -i "s/Bahmni Home/Pinotech EMR Login/g" "$HTML_DIR/index.html" && \
  echo "✅ Updated <title> in index.html"
else
  echo "⚠️  index.html not found, skipping title update"
fi

# 2) Find and update any JS files containing the phrase "Bahmni EMR"
UPDATED=0

# Prefer hashed home.min.*.js if they exist
FILES=""
if ls "$HTML_DIR"/home.min*.js >/dev/null 2>&1; then
  FILES=$(ls -1 "$HTML_DIR"/home.min*.js 2>/dev/null || true)
fi

# Fallback: any JS in the directory that actually contains the text
if [ -z "$FILES" ]; then
  FILES=$(grep -l "Bahmni EMR" "$HTML_DIR"/*.js 2>/dev/null || true)
fi

if [ -n "$FILES" ]; then
  for f in $FILES; do
    if grep -q "Bahmni EMR" "$f"; then
      sed -i "s/Bahmni EMR/Pinotech EMR/g" "$f"
      echo "✅ Updated login heading in $(basename "$f")"
      UPDATED=1
    fi
  done
else
  echo "⚠️  No matching JS files found to update."
fi

if [ "$UPDATED" -eq 0 ]; then
  echo "ℹ️  No JS replacements performed (string not found)."
fi
'

echo "🔁 Restarting web container..."
docker restart "$WEB_CONTAINER" >/dev/null
echo "✅ Pinotech EMR branding applied and container restarted."
echo "🧼 Tip: Hard refresh your browser (or use incognito). If using Cloudflare, purge cache for the site to see changes immediately."
