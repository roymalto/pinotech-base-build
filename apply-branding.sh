#!/bin/bash

# Identify the Bahmni web container name
WEB_CONTAINER=$(docker ps --filter "name=bahmni-web" --format "{{.Names}}")

# Copy logo files
docker cp custom-branding/logo.png $WEB_CONTAINER:/usr/local/apache2/htdocs/bahmni/home/logo.png
docker cp custom-branding/logo.png $WEB_CONTAINER:/usr/local/apache2/htdocs/bahmni_config/openmrs/apps/home/logo.png
docker cp custom-branding/bahmniLogoFull.png $WEB_CONTAINER:/usr/local/apache2/htdocs/bahmni/images/bahmniLogoFull.png
docker cp custom-branding/favicon.ico $WEB_CONTAINER:/usr/local/apache2/htdocs/bahmni/home/favicon.ico
docker cp custom-branding/bahmni-logo.png $WEB_CONTAINER:/usr/local/apache2/htdocs/bahmni-logo.png
docker cp custom-branding/favicon.ico $WEB_CONTAINER:/usr/local/apache2/htdocs/bahmni/favicon.ico
docker cp custom-branding/logo.png $WEB_CONTAINER:/usr/local/apache2/htdocs/bahmni/logo.png
docker cp custom-branding/analytics.png $WEB_CONTAINER:/usr/local/apache2/htdocs/bahmni/images/analytics.png
docker cp custom-branding/app.png $WEB_CONTAINER:/usr/local/apache2/htdocs/bahmni/images/app.png
docker cp custom-branding/bahmniLogo.png $WEB_CONTAINER:/usr/local/apache2/htdocs/bahmni/images/bahmniLogo.png

# Copy localization and config files
docker cp custom-branding/locale_en.json $WEB_CONTAINER:/usr/local/apache2/htdocs/bahmni_config/openmrs/apps/home/locale_en.json
docker cp custom-branding/whiteLabel.json $WEB_CONTAINER:/usr/local/apache2/htdocs/bahmni_config/openmrs/apps/home/whiteLabel.json
docker cp custom-branding/app.json $WEB_CONTAINER:/usr/local/apache2/htdocs/bahmni_config/openmrs/apps/home/app.json
docker cp custom-branding/apps.json $WEB_CONTAINER:/usr/local/apache2/htdocs/bahmni_config/openmrs/apps.json

# Restart web container to reflect changes
docker restart $WEB_CONTAINER

echo "✅ Branding files copied and web container restarted."
