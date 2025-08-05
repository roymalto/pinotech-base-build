#!/bin/bash

echo "🔧 Applying Pinotech EMR branding to login page..."

# Set container name
WEB_CONTAINER=$(docker ps --filter "name=bahmni-web" --format "{{.Names}}")

if [ -z "$WEB_CONTAINER" ]; then
  echo "❌ Bahmni web container not found."
  exit 1
fi

# Step 1: Update title in index.html
echo "✅ Updating <title> in index.html..."
docker exec "$WEB_CONTAINER" sed -i 's/Bahmni Home/Pinotech EMR Login/g' /usr/local/apache2/htdocs/bahmni/home/index.html

# Step 2: Update JS login heading
echo "✅ Updating login heading in home.min.6c87978c.js..."
docker exec "$WEB_CONTAINER" sed -i 's/Bahmni EMR/Pinotech EMR/g' /usr/local/apache2/htdocs/bahmni/home/home.min.6c87978c.js

echo "✅ Pinotech EMR branding applied successfully!"
echo "🔁 Please hard refresh the login page or use incognito mode to view the updated branding."
