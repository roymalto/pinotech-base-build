start on ~Projects/
Run setup-bahmni.sh
cp ~/Projects/ATISHEALTH/custom-branding/docker-compose.yml ~/Projects/ATISHEALTH/bahmni-docker/bahmni-standard/
cp ~/Projects/ATISHEALTH/custom-branding/.env ~/Projects/ATISHEALTH/bahmni-docker/bahmni-standard/
cd ~/Projects/ATISHEALTH/bahmni-docker/bahmni-standard
docker compose down
