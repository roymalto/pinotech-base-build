#!/bin/bash

WEB_CONTAINER=$(docker ps --filter "name=bahmni-web" --format "{{.Names}}")

docker cp custom-branding/logo.png $WEB_CONTAINER:/usr/local/apache2/htdocs/bahmni/home/logo.png
docker cp custom-branding/logo.png $WEB_CONTAINER:/usr/local/apache2/htdocs/bahmni_config/openmrs/apps/home/logo.png
docker cp custom-branding/bahmniLogoFull.png $WEB_CONTAINER:/usr/local/apache2/htdocs/bahmni/images/bahmniLogoFull.png
docker cp custom-branding/favicon.ico $WEB_CONTAINER:/usr/local/apache2/htdocs/bahmni/home/favicon.ico
docker cp custom-branding/locale_en.json $WEB_CONTAINER:/usr/local/apache2/htdocs/bahmni_config/openmrs/apps/home/locale_en.json
docker cp custom-branding/whitelabel.json $WEB_CONTAINER:/usr/local/apache2/htdocs/bahmni_config/openmrs/apps/home/whitelabel.json
docker cp custom-branding/app.json $WEB_CONTAINER:/usr/local/apache2/htdocs/bahmni_config/openmrs/apps/home/app.json
docker cp custom-branding/apps.json $WEB_CONTAINER:/usr/local/apache2/htdocs/bahmni_config/openmrs/apps.json

docker restart $WEB_CONTAINER

echo "✅ Branding files copied and web container restarted."
